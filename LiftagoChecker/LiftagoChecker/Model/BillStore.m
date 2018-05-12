//
//  BillStore.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 04/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "BillStore.h"
#import "Store.h"
#import "Bill.h"

@interface BillStore()

@property (nonatomic, strong, readonly) Store *store;

@end

@implementation BillStore

+ (BillStore *)store {
    return [[BillStore alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _store = [[Store alloc] initWithIdentifier:@"bill"];
    }
    return self;
}

- (void)storeBill:(Bill *)bill {
    [self.store storeItem:bill];
}

- (Bill *)retrieveBill {
    return (Bill *) [self.store retrieveItem] ?: [[Bill alloc] initWithEntries:@[]];
}

@end
