//
//  Bill.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillEntry.h"

@interface Bill : NSObject <NSCoding>

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithEntries:(nonnull NSArray<BillEntry *> *)entries;

@property (nonatomic, strong, nonnull, readonly) BillEntry *total;

@end
