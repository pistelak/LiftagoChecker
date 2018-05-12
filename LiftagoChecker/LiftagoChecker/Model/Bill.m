//
//  Bill.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import "Bill.h"

@implementation Bill

- (instancetype)initWithEntries:(NSArray<BillEntry *> *)entries {
    
    // TODO: case insensitive
    if ([[NSSet setWithArray:[entries valueForKey:@"currency"]] isSubsetOfSet:[NSSet setWithArray:@[@"Kč", @"CZK"]]] == NO) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _total = [[BillEntry alloc] initWithAmount:[entries valueForKeyPath:@"@sum.amount"] currency:@"Kč"];
    }
    
    return self;
}

#pragma mark -

- (NSString *)description {
    return [self.total description];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSString *currency = [aDecoder decodeObjectForKey:@"currency"];
        NSNumber *amount   = [aDecoder decodeObjectForKey:@"amount"];
        _total = [[BillEntry alloc] initWithAmount:amount currency:currency];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.total.amount forKey:@"amount"];
    [aCoder encodeObject:self.total.currency forKey:@"currency"];
}

@end
