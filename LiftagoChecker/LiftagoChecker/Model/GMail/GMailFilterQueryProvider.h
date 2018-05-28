//
//  GMailFilterQueryProvider.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 06/07/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GMailFilterQuery;

@protocol GMailFilterQueryProvider<NSObject>

- (id<GMailFilterQuery>)query;

@end

@interface BussinesRidesInCurrentMonthGMailFilterQueryProvider: NSObject <GMailFilterQueryProvider>

- (id<GMailFilterQuery>)query;

@end
