#import <UIKit/UIKit.h>

@interface UITableView (Barefoot)

- (UITableViewCell *)dequeueOrAllocInitAutoreleaseReusableCellWithIdentifier:(NSString *)identifier;

@end
