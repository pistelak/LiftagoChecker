//
//  BillStore.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 04/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN;

@class Bill;

@interface BillStore : NSObject

+ (BillStore *)store;

- (void)storeBill:(Bill *)bill;

- (Bill *)retrieveBill;

@end

NS_ASSUME_NONNULL_END;
