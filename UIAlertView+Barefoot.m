#import "UIAlertView+Barefoot.h"

#import <objc/runtime.h>

@interface UIAlertViewDelegateWrapper : NSObject

@property (copy) void(^completionBlock)(UIAlertView *alertView, NSInteger buttonIndex);

@end

@implementation UIAlertViewDelegateWrapper

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (self.completionBlock) self.completionBlock(alertView, buttonIndex);
}

- (void)alertViewCancel:(UIAlertView *)alertView {
  if (self.completionBlock) self.completionBlock(alertView, alertView.cancelButtonIndex);
}

@end

@interface UIAlertViewHangaround : NSObject

@property NSString *_hash;

+ (BOOL)alertViewIsAlreadyShowing:(NSString *)hash;

@end

@implementation UIAlertViewHangaround

static NSMutableDictionary *hashes;

- (void)setHash:(NSString *)hash {
  self._hash = hash;
  if (!hashes) {
    hashes = [NSMutableDictionary dictionary];
  }
  [hashes setValue:@"YES" forKey:hash];
}

+ (BOOL)alertViewIsAlreadyShowing:(NSString *)hash {
  if ([hashes objectForKey:hash]) {
    return YES;
  }
  return NO;
}

- (void)dealloc {
  [hashes removeObjectForKey:self._hash];
}

@end

static const char kUIAlertViewWrapperDelegate;
static const char kUIAlertViewHangaround;

@implementation UIAlertView (Barefoot)

- (id)initWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(UIAlertView *, NSInteger))completionBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...  {
  UIAlertViewDelegateWrapper *alertWrapper = [[UIAlertViewDelegateWrapper alloc] init];
  alertWrapper.completionBlock = completionBlock;
  
  self = [self initWithTitle:title message:message delegate:alertWrapper cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
  
  if (self) {
    objc_setAssociatedObject(self, &kUIAlertViewWrapperDelegate, alertWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (otherButtonTitles) {
      NSString *buttonTitle;
      va_list argumentList;
      va_start(argumentList, otherButtonTitles);
      while ((buttonTitle = va_arg(argumentList, NSString*))) [self addButtonWithTitle:buttonTitle];
      va_end(argumentList);
    }
  }
  return self;
}

- (void)showOne {
  NSString *hash = [NSString stringWithFormat:@"%@%@", self.title, self.message];
  if (![UIAlertViewHangaround alertViewIsAlreadyShowing:hash]) {
    UIAlertViewHangaround *hangaround = [[UIAlertViewHangaround alloc] init];
    [hangaround setHash:hash];
    objc_setAssociatedObject(self, &kUIAlertViewHangaround, hangaround, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self show];
  }
}

@end

