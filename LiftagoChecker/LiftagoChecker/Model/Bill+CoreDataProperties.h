
#import "Bill+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Bill (CoreDataProperties)

+ (NSFetchRequest<Bill *> *)fetchRequest;
+ (NSFetchRequest<Bill *> *)fetchRequestForBillWithMonthIndex:(NSUInteger)monthIndex;

@property (nullable, nonatomic, retain) NSNumber *monthIndex;
@property (nullable, nonatomic, retain) NSSet<BillEntry *> *entries;

- (void)addEntry:(BillEntry *)anEntry;
- (void)removeEntry:(BillEntry *)anEntry;

@end

NS_ASSUME_NONNULL_END
