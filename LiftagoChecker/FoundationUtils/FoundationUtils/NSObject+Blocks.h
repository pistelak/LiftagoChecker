//
//  NSObject+Blocks.h
//  FoundationUtils
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Blocks)

- (void)performBlock:(void(^)(void))block;
- (void)performBlock:(void (^)(id))block withObject:(id)object;
- (void)performBlock:(void (^)(id, id))block withObject:(id)object1 withObject:(id)object2;

@end
