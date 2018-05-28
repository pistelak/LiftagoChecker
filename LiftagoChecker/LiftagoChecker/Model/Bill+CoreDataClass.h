
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BillEntry;

NS_ASSUME_NONNULL_BEGIN

@interface Bill : NSManagedObject

- (NSNumber *)totalAmount;
- (NSString *)formattedValue;

@end

NS_ASSUME_NONNULL_END

#import "Bill+CoreDataProperties.h"
