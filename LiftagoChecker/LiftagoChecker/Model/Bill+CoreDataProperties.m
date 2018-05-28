
#import "Bill+CoreDataProperties.h"

@interface Bill (CoreDataGeneratedAccessors)

- (void)addEntriesObject:(BillEntry *)value;
- (void)removeEntriesObject:(BillEntry *)value;

@end

@implementation Bill (CoreDataProperties)

+ (NSFetchRequest<Bill *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Bill"];
}

+ (NSFetchRequest<Bill *> *)fetchRequestForBillWithMonthIndex:(NSUInteger)monthIndex {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Bill"];
    request.predicate = [NSPredicate predicateWithFormat:@"monthIndex == %@", @(monthIndex)];
    return request;
}

@dynamic entries;
@dynamic monthIndex;

- (void)addEntry:(BillEntry *)anEntry {
    [self addEntriesObject:anEntry];
}

-(void)removeEntry:(BillEntry *)anEntry {
    [self removeEntriesObject:anEntry];
}

@end
