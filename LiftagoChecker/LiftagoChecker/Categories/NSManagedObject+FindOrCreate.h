
#import <CoreData/CoreData.h>

@interface NSManagedObject (FindOrCreate)

+ (__kindof NSManagedObject *)findOrCreateWithSelectorAsPrimaryKey:(SEL)property
                                                             value:(id)value
                                                         inContext:(NSManagedObjectContext *)context;
@end
