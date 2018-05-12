//
//  GMailFilterQuery.m
//  GMailService
//
//  Created by Radek Pistelak on 11/02/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "GMailFilterQuery.h"
#import "NSCalendar+DateFactory.h"

@implementation GMailSubjectFilterQuery

- (instancetype)initWithSubject:(NSString *)subject {
    self = [super init];
    _subject = subject;
    return self;
}

- (NSString *)description {
    return [@"subject:" stringByAppendingString:self.subject];
}

@end

@implementation GMailFromFilterQuery

- (instancetype)initWithSender:(NSString *)sender {
    self = [super init];
    _sender = sender;
    return self;
}

- (NSString *)description {
    return [@"from:" stringByAppendingString:self.sender];
}

@end

@implementation GMailMonthFilterQuery

- (instancetype)initWithMonthIndex:(NSUInteger)indexOfMonth {
    self = [super init];
    _indexOfMonth = indexOfMonth;
    return self;
}

- (NSString *)description {
    
    NSDateInterval *dateInterval = [[NSCalendar currentCalendar] dateIntervalForMonth:self.indexOfMonth];
    
    return [[[GMailDateIntervalFilterQuery alloc] initWithDateInterval:dateInterval] description];
}

@end

@implementation GMailDateIntervalFilterQuery

- (instancetype)initWithDateInterval:(NSDateInterval *)interval {
    self = [super init];
    _interval = interval;
    return self;
}

- (NSString *)description {
    
    NSArray *queries = @[
        [[GMailAfterFilterQuery alloc] initWithDate:self.interval.startDate],
        [[GMailBeforeFilterQuery alloc] initWithDate:self.interval.endDate]
    ];
    
    return [[[GMailCompoundFilterQuery alloc] initWithQueries:queries] description];
}

@end

@interface GMailDateFilterFormatter: NSObject

- (NSString *)formattedDate:(NSDate *)date;

@property (nonatomic, readonly) NSDateFormatter *dateFormatter;

@end

@implementation GMailDateFilterFormatter: NSObject

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.calendar = [NSCalendar currentCalendar];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.timeZone = [NSTimeZone systemTimeZone];
        dateFormatter.dateFormat = @"yyyy/MM/dd";
    });
    return dateFormatter;
}

-(NSString *)formattedDate:(NSDate *)date {
    return [self.dateFormatter stringFromDate:date];
}

@end

@implementation GMailBeforeFilterQuery

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];
    _date = date;
    return self;
}

- (NSString *)formattedDate {
    return [[[GMailDateFilterFormatter alloc] init] formattedDate:self.date];
}

- (NSString *)description {
    return [@"before:" stringByAppendingString:[self formattedDate]];
}

@end

@implementation GMailAfterFilterQuery

- (instancetype)initWithDate:(NSDate *)date {
    self = [super init];
    _date = date;
    return self;
}

- (NSString *)formattedDate {
    return [[[GMailDateFilterFormatter alloc] init] formattedDate:self.date];
}

- (NSString *)description {
    return [@"after:" stringByAppendingString:[self formattedDate]];
}

@end

@implementation GMailCompoundFilterQuery

- (instancetype)initWithQueries:(NSArray<id<GMailFilterQuery>> *)queries {
    self = [super init];
    _queries = queries;
    return self;
}

- (NSString *)description {
    return [self.queries componentsJoinedByString:@" "];
}

@end
