//
//  NSObject+Blocks.m
//  FoundationUtils
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "NSObject+Blocks.h"

@implementation NSObject (Blocks)

- (void)performBlock:(void (^)())block {
    
    if (block) {
        block();
    }
}

- (void)performBlock:(void (^)(id))block withObject:(id)object {
    
    if (block) {
        block(object);
    }
    
}

- (void)performBlock:(void (^)(id, id))block withObject:(id)object1 withObject:(id)object2 {
    
    if (block) {
        block(object1, object2);
    }
}

@end
