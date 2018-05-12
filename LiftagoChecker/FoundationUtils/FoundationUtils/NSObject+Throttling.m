//
//  NSObject+Throttling.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 03/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "NSObject+Throttling.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

const char * kThrottling_mappingLastUsageToSelectorKey = "kThrottling_mappingLastUsageToSelectorKey";

@implementation NSObject (Throttling)

- (NSMutableDictionary<NSString *, NSDate *> *)throttling_mappingLastUsageToSelector {
    
    NSMutableDictionary *mappingDictionary = objc_getAssociatedObject(self, kThrottling_mappingLastUsageToSelectorKey);
    
    if (mappingDictionary == nil) {
        mappingDictionary = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(
             self,
             kThrottling_mappingLastUsageToSelectorKey,
             mappingDictionary,
             OBJC_ASSOCIATION_RETAIN
        );
    }
    
    return mappingDictionary;
}

- (void)performSelector:(SEL)selector
             withObject:(id)anObject
       throttleInterval:(NSTimeInterval)anInterval
            performLast:(BOOL)performLast {

    id selectorName = NSStringFromSelector(selector);
    id lastInvocation = [[self throttling_mappingLastUsageToSelector] objectForKey:selectorName];
    
    if (lastInvocation == nil || fabs([lastInvocation timeIntervalSinceNow]) >= anInterval) {
        [self performSelector:selector withObject:anObject];
        [[self throttling_mappingLastUsageToSelector] setObject:[NSDate date] forKey:selectorName];
    } else {
        
        if (performLast) {
            NSTimeInterval remaining = anInterval - [lastInvocation timeIntervalSinceNow];
            [self performSelector:selector withObject:anObject debounceInterval:remaining];
        }
    }
}

- (void)performSelector:(SEL)selector
             withObject:(id)anObject
       throttleInterval:(NSTimeInterval)anInterval {
    
    [self performSelector:selector withObject:anObject throttleInterval:anInterval performLast:NO];
}

- (void)performSelector:(SEL)selector
             withObject:(id)anObject
       debounceInterval:(NSTimeInterval)anInterval {
    
    [self.class cancelPreviousPerformRequestsWithTarget:self selector:selector object:anObject];
    [self performSelector:selector withObject:anObject afterDelay:anInterval];
}

@end

#pragma clang diagnostic pop
