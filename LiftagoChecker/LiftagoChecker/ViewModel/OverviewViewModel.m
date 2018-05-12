//
//  OverviewViewModel.m
//  LiftagoChecker
//
//  Created by Radek Pistelak on 03/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import "OverviewViewModel.h"
#import <GMailService/GMailFilterQuery.h>
#import "GoogleService.h"
#import "BillStore.h"
#import "Bill.h"
#import "LiftagoSnippetMessageParser.h"

@interface OverviewViewModel() <GoogleServiceDelegate>

@property (nonatomic, strong, readonly) GoogleService *googleService;
@property (nonatomic, strong, readonly) BillStore *store;

@property (nonatomic, assign, readwrite) BOOL isLoading;
@property (nonatomic, assign, readwrite) BOOL isLoggedIn;
@property (nonatomic, strong, readwrite) Bill *bill;

@end

@implementation OverviewViewModel

- (instancetype)initWithGoogleService:(GoogleService *)googleService store:(BillStore *)store {
    self = [super init];
    if (self) {
        _googleService = googleService;
        _googleService.delegate = self;
        _store = store;
    }
    return self;
}

#pragma mark - Lifecycle

- (void)onStart {
    [self setBill:[self.store retrieveBill]];
    [self setIsLoading:YES];
    
    if ([self.googleService logInSilentlyIfPossible] == NO) {
        [self.googleService logIn];
    }
}

- (void)onFinish {
    [self.store storeBill:self.bill];
}

#pragma mark - LogIn

- (void)logIn {
    [self.googleService logIn];
}

- (void)googleServiceDidLogIn:(GoogleService *)service {
    [self setIsLoggedIn:YES];
    [self updateBill];
}

- (void)googleService:(GoogleService *)service logInDidFailWithError:(NSError *)error {
    [self setIsLoading:NO];
    [self setIsLoggedIn:NO];
    [self.delegate overviewViewModel:self needsDisplayError:error];
}

#pragma mark - Update

- (void)updateBill {
    [self setIsLoading:YES];
    
    NSUInteger currentMonth = [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]];
    
    NSArray *queries = @[
         [[GMailFromFilterQuery alloc] initWithSender:@"service@liftago.com"],
         [[GMailSubjectFilterQuery alloc] initWithSubject:@"\"Business+\""],
         [[GMailMonthFilterQuery alloc] initWithMonthIndex:currentMonth],
    ];
    
    [self.googleService fetchMessagesWithFilterQuery:[[GMailCompoundFilterQuery alloc] initWithQueries:queries]];
}

- (void)googleService:(GoogleService *)service didFetchMessages:(NSArray *)messages {
    [self setIsLoading:NO];

    NSArray *snippets = [messages valueForKey:@"snippet"];
    NSArray *entries = [[LiftagoSnippetMessageParser new] entriesFromMassages:snippets];
    
    self.bill = [[Bill alloc] initWithEntries:entries];
}

- (void)googleService:(GoogleService *)service fetchingMessagesDidFailWithError:(NSError *)error {
    [self setIsLoading:NO];
    [self.delegate overviewViewModel:self needsDisplayError:error];
}

@end
