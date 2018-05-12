//
//  BillEntry.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillEntry : NSObject

- (instancetype)initWithAmount:(id)amount currency:(NSString *)currency;
    
@property (nonatomic, copy, readonly) NSNumber *amount;
@property (nonatomic, copy, readonly) NSString *currency;

- (NSString *)formattedValue;

@end

NS_ASSUME_NONNULL_END
