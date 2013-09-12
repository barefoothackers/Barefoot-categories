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

static const char kUIAlertViewWrapperDelegate;

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

@end

