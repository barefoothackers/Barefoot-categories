#import "UIView+Barefoot.h"
#import <QuartzCore/CALayer.h>

@implementation UIView (Barefoot)

- (CGSize)subviewBounds
{
  // Semi-cheap hack: if we are measuring a UIScrollView, it also has two UIImageView children
  // for the scrollbars which must be disabled and then re-enabled after calculating the bounds.
  UIScrollView *scrollView = nil;
  BOOL showsHorizontalScrollIndicator = NO;
  BOOL showsVerticalScrollIndicator = NO;
  if([self isKindOfClass:[UIScrollView class]]) {
    scrollView = (UIScrollView *)self;
    showsHorizontalScrollIndicator = scrollView.showsHorizontalScrollIndicator;
    showsVerticalScrollIndicator = scrollView.showsVerticalScrollIndicator;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
  }

  CGSize bounds = CGSizeZero;
  for(UIView *subView in self.subviews)
  {
    CGRect f = subView.frame;
    bounds.width = MAX(bounds.width, f.origin.x + f.size.width);
    bounds.height = MAX(bounds.height, f.origin.y + f.size.height);
  }

  if([self isKindOfClass:[UIScrollView class]]) {
    [scrollView setShowsHorizontalScrollIndicator:showsHorizontalScrollIndicator];
    [scrollView setShowsVerticalScrollIndicator:showsVerticalScrollIndicator];
  }
  return bounds;
}

- (void)addSubviewAtBottom:(UIView *)view
{
  [self addSubviewAtBottom:view withPadding:0];
}

- (void)addSubviewAtRight:(UIView *)view
{
  CGSize bounds = [self subviewBounds];
  CGRect frame = view.frame;
  frame.origin.x = bounds.width;
  view.frame = frame;
  [self addSubviewAtRight:view withPadding:0];
}

- (void)addSubview:(UIView *)view atRightOf:(UIView *)otherView
{
  [self addSubview:view atRightOf:otherView withOffset:0];
}

- (void)addSubview:(UIView *)view atRightOf:(UIView *)otherView withOffset:(size_t)offset
{
  CGRect frame = view.frame;
  frame.origin.x = otherView.frame.origin.x + otherView.frame.size.width + offset;
  frame.origin.y = otherView.frame.origin.y;
  view.frame = frame;
  [self addSubview:view];
}

- (void)addSubviewAtBottom:(UIView *)view withPadding:(size_t)padding
{
  CGSize bounds = [self subviewBounds];
  CGRect frame = view.frame;
  frame.origin.y = bounds.height + padding;
  view.frame = frame;
  [self addSubview:view];
}

- (void)addSubviewAtRight:(UIView *)view withPadding:(size_t)padding
{
  CGSize bounds = [self subviewBounds];
  CGRect frame = view.frame;
  frame.origin.x = bounds.width + padding;
  view.frame = frame;
  [self addSubview:view];
}

- (void)insertSubview:(UIView *)view beneath:(UIView *)otherView {
  [self insertSubview:view beneath:otherView withTopOffset:0 bottomOffset:0];
}
- (void)insertSubview:(UIView *)view beneath:(UIView *)otherView withTopOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset {
  CGRect frame;
  for (UIView *subview in self.subviews) {
    frame = subview.frame;
    if (frame.origin.y >= otherView.frame.origin.y + otherView.frame.size.height) {
      frame.origin.y += view.frame.size.height + topOffset + bottomOffset;
      subview.frame = frame;
    }
  }
  frame = view.frame;
  frame.origin.y = otherView.frame.origin.y + otherView.frame.size.height + topOffset;
  view.frame = frame;
  [self addSubview:view];
}

- (void)sizeToFitWithPadding:(CGSize)padding
{
  CGSize bounds = [self subviewBounds];
  CGRect frame = self.frame;
  frame.size.height = bounds.height + padding.height;
  frame.size.width = bounds.width + padding.width;
  self.frame = frame;
}

- (void)sizeToFitWithPadding:(CGSize)padding withMinimumSize:(CGSize)minSize
{
  CGSize bounds = [self subviewBounds];
  CGRect frame = self.frame;
  frame.size.height = MAX(bounds.height + padding.height, minSize.height);
  frame.size.width = MAX(bounds.width + padding.width, minSize.width);
  self.frame = frame;
}

- (void)sizeHeightToFitWithPadding:(size_t)h
{
  CGSize bounds = [self subviewBounds];
  CGRect frame = self.frame;
  frame.size.height = bounds.height + h;
  self.frame = frame;
}

- (void)describeWithSpaces:(NSUInteger)spaces {
  NSString *s = @"";
  for (NSUInteger i = 0; i <= spaces; i++) {
    s = [s stringByAppendingString:@" "];
  }
  NSLog(@"%@%@", s, self);
  spaces += 2;
  for (UIView *subview in self.subviews) {
    [subview describeWithSpaces:spaces];
  }
}

- (void)describe {
  [self describeWithSpaces:0];
}

@end
