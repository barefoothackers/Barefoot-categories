#import "UIImage+Barefoot.h"

@implementation UIImage (Barefoot)

+ (NSArray*)imagesFromBaseName:(NSString*)base withEnding:(NSString*)ending {
  NSArray *resourceNames = [[NSBundle mainBundle] pathsForResourcesOfType:ending inDirectory:nil];
  NSIndexSet *matchingImageIndexes = [resourceNames indexesOfObjectsPassingTest:^BOOL (id element, NSUInteger i, BOOL *stop) {
    NSString *path = (NSString *)element;
    NSString *imageName = [path lastPathComponent];
    if ([imageName hasPrefix:base] && ![imageName hasSuffix:[NSString stringWithFormat:@"@2x%@",ending]]) {
      return YES;
    }
    return NO;
  }];
  NSArray *imageNames = [resourceNames objectsAtIndexes:matchingImageIndexes];
  NSMutableArray *images = [NSMutableArray arrayWithCapacity:[imageNames count]];
  for(NSString *imageName in imageNames) {
    [images addObject:[UIImage imageNamed:[imageName lastPathComponent]]];
  }
  if ([images count] == 0) {
    return nil;
  }
  return images;
}

@end
