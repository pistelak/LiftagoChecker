//
//  NSArray+Emptiness.m
//  FoundationUtils
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "NSArray+Emptiness.h"

@implementation NSArray (Emptiness)

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (BOOL)isNonEmpty {
    return [self count] > 0;
}

@end
