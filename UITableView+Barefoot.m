#import "UITableView+Barefoot.h"

@implementation UITableView (Barefoot)

- (UITableViewCell *)dequeueOrAllocInitAutoreleaseReusableCellWithIdentifier:(NSString *)identifier {
  UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  return cell;
}

@end
