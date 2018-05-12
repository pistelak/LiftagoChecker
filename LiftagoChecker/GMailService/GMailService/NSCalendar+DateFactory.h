//
//  NSCalendar+DateFactory.h
//  GMailService
//
//  Created by Radek Pistelak on 11/02/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (DateFactory)

- (NSDateInterval *)dateIntervalForMonth:(NSUInteger)month;

- (NSDate *)firstDayOfMonth:(NSUInteger)month;
- (NSDate *)lastDayOfMonth:(NSUInteger)month;

@end
