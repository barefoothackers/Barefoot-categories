#import "UIView+Barefoot.h"

@implementation UIView (Barefoot)

- (UIView *)findFirstResponder {
  if ([self isFirstResponder])
    return self;

  for (UIView *subview in self.subviews) {
    UIView *firstResponder = [subview findFirstResponder];
    if (firstResponder)
      return firstResponder;
  }

  return nil;
}

@end
