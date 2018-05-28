//
//  GMailFilterQueryProvider.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 06/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "GMailFilterQueryProvider.h"

@import GMailService.GMailFilterQuery;

@implementation BussinesRidesInCurrentMonthGMailFilterQueryProvider

- (NSUInteger)currentMonth {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]];
}

- (GMailCompoundFilterQuery *)query {
    
    NSArray *queries = @[
         [[GMailFromFilterQuery alloc] initWithSender:@"service@liftago.com"],
         [[GMailSubjectFilterQuery alloc] initWithSubject:@"\"Business+\""],
         [[GMailMonthFilterQuery alloc] initWithMonthIndex:[self currentMonth]],
    ];
    
    return [[GMailCompoundFilterQuery alloc] initWithQueries:queries];
}

@end
