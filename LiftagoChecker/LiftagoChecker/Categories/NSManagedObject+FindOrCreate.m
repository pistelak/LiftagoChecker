
#import "NSManagedObject+FindOrCreate.h"

@implementation NSManagedObject (FindOrCreate)

+ (NSManagedObject *)findOrCreateWithSelectorAsPrimaryKey:(SEL)property
                                              value:(id)value
                                          inContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    
    NSString *format = [NSString stringWithFormat:@"%@ == %@", NSStringFromSelector(property), value];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:format];
    
    NSArray *results = [context executeFetchRequest:fetchRequest error:nil];

    if ([results count] > 1) {
        NSAssert(NO, @"There should be only one result!");
    }
    
    __kindof NSManagedObject *object = [results firstObject];
    
    if (object == nil) {
        object = [[self alloc] initWithContext:context];
        [object setValue:value forKey:NSStringFromSelector(property)];
    }
    
    return object;
}

@end
