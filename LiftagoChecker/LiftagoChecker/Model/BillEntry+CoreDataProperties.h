
#import "BillEntry+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BillEntry (CoreDataProperties)

+ (NSFetchRequest<BillEntry *> *)fetchRequest;

@property (nonatomic) NSNumber *amount;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *snippet;

@property (nonatomic, strong, readonly) Bill *bill;

@end

NS_ASSUME_NONNULL_END
