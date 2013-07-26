#import "NSDate+Barefoot.h"

@implementation NSDate (Barefoot)

- (NSString *)stringWithFormat:(NSString *)format {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:format];
  return [dateFormatter stringFromDate:self];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:dateStyle];
  [dateFormatter setTimeStyle:timeStyle];
  return [dateFormatter stringFromDate:self];
}

@end
