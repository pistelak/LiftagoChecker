
#import "BillEntry+CoreDataProperties.h"

@implementation BillEntry (CoreDataProperties)

+ (NSFetchRequest<BillEntry *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"BillEntry"];
}

@dynamic amount;
@dynamic currency;
@dynamic snippet;
@dynamic bill;

@end
