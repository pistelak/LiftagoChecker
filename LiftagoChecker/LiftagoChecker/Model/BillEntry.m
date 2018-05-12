//
//  BillEntry.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "BillEntry.h"

@implementation BillEntry

- (instancetype)initWithAmount:(id)price currency:(NSString *)currency {
    self = [super init];
    if (self) {
        // TODO: add ifResponds
        _amount = @([price integerValue]);
        _currency = [currency copy];
    }
    
    return self;
}

- (NSString *)formattedValue {
    return [NSString stringWithFormat:@"%@ %@", self.amount, self.currency];
}

#pragma mark - Debug

- (NSString *)description {
    return [self formattedValue];
}

#pragma mark - Equality

- (NSUInteger)hash {
    return [self.amount hash] * 31u + [self.currency hash];
}

- (BOOL)isEqual:(id)object {
    return [object isKindOfClass:[BillEntry class]]
        && [self.amount isEqual:[object amount]]
        && [self.currency isEqual:[object currency]];
}

@end
