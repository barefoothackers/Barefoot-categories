#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Barefoot)
- (CGSize)subviewBounds;
- (void)addSubviewAtBottom:(UIView *)view;
- (void)addSubviewAtRight:(UIView *)view;
- (void)addSubviewAtBottom:(UIView *)view withPadding:(size_t)padding;
- (void)addSubviewAtRight:(UIView *)view withPadding:(size_t)padding;
- (void)addSubview:(UIView *)view atRightOf:(UIView *)otherView;
- (void)addSubview:(UIView *)view atRightOf:(UIView *)otherView withOffset:(size_t)offset;
- (void)insertSubview:(UIView *)view beneath:(UIView *)otherView;
- (void)insertSubview:(UIView *)view beneath:(UIView *)otherView withTopOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset;
- (void)sizeToFitWithPadding:(CGSize)padding;
- (void)sizeToFitWithPadding:(CGSize)padding withMinimumSize:(CGSize)minSize;
- (void)sizeHeightToFitWithPadding:(size_t)h;
- (void)describe;
@end
