//
//  NSCalendar+DateFactory.m
//  GMailService
//
//  Created by Radek Pistelak on 11/02/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "NSCalendar+DateFactory.h"

@implementation NSCalendar (DateFactory)

- (NSDate *)firstDayOfMonth:(NSUInteger)month {
    NSDateComponents *components = [self components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:[NSDate date]];
    components.month = month;
    components.day = 1;
    
    return [self dateFromComponents:components];
}

- (NSDate *)lastDayOfMonth:(NSUInteger)month {

    NSDateComponents *components = [self components:(NSCalendarUnitYear|NSCalendarUnitMonth) fromDate:[NSDate date]];
    components.day = 0;
    components.month = month+1;

    return [self dateFromComponents:components];
}

- (NSDateInterval *)dateIntervalForMonth:(NSUInteger)month {
    return [[NSDateInterval alloc] initWithStartDate:[self firstDayOfMonth:month]
                                             endDate:[self lastDayOfMonth:month]];
}

@end
