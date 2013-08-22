#import <UIKit/UIKit.h>

@interface UIAlertView (Barefoot)

- (id)initWithTitle:(NSString *)title message:(NSString *)message completion:(void(^)(UIAlertView *alertview, NSInteger buttonIndex))completionBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
