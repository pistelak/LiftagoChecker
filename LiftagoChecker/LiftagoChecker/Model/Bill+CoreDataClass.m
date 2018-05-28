
#import "Bill+CoreDataClass.h"

@implementation Bill

- (NSString *)formattedValue {
    return [[self.totalAmount stringValue] stringByAppendingString:@"CZK"];
}

- (NSNumber *)totalAmount {
    return [self.entries valueForKeyPath:@"@sum.amount"];
}

@end
