//
//  GMailFilterQuery.h
//  GMailService
//
//  Created by Radek Pistelak on 11/02/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GMailFilterQuery <NSObject>

- (NSString *)description;

@end

@interface GMailSubjectFilterQuery: NSObject <GMailFilterQuery>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSubject:(NSString *)subject;

@property (nonatomic, copy, readonly) NSString *subject;

@end

@interface GMailFromFilterQuery: NSObject <GMailFilterQuery>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSender:(NSString *)sender;

@property (nonatomic, copy, readonly) NSString *sender;

@end

@interface GMailMonthFilterQuery: NSObject <GMailFilterQuery>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMonthIndex:(NSUInteger)indexOfMonth;

@property (nonatomic, readonly) NSUInteger indexOfMonth;

@end

@interface GMailDateIntervalFilterQuery: NSObject <GMailFilterQuery>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDateInterval:(NSDateInterval *)interval;

@property (nonatomic, copy, readonly) NSDateInterval *interval;

@end 

@interface GMailBeforeFilterQuery: NSObject <GMailFilterQuery>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDate:(NSDate *)date;

@property (nonatomic, copy, readonly) NSDate *date;

@end

@interface GMailAfterFilterQuery: NSObject <GMailFilterQuery>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDate:(NSDate *)date;

@property (nonatomic, copy, readonly) NSDate *date;

@end

@interface GMailCompoundFilterQuery: NSObject <GMailFilterQuery>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithQueries:(NSArray<id<GMailFilterQuery>> *)queries;

@property (nonatomic, copy, readonly) NSArray<id<GMailFilterQuery>> *queries;

@end

NS_ASSUME_NONNULL_END
