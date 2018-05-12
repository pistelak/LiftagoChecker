//
//  GMailService.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMailFilterQuery.h"

@protocol GTMFetcherAuthorizationProtocol;
@class GMailService;

NS_ASSUME_NONNULL_BEGIN

@protocol GMailServiceDelegate <NSObject>

- (void)gmailService:(GMailService *)service didFetchMessages:(NSArray *)messages;
- (void)gmailService:(GMailService *)service didFailWithError:(NSError *)error;

@end

@interface GMailService : NSObject

- (instancetype)initWithAuthorizer:(id<GTMFetcherAuthorizationProtocol>)authorizer;

@property (nonatomic, weak) id<GMailServiceDelegate> delegate;

- (void)fetchMessagesWithFilterQuery:(nullable id<GMailFilterQuery>)filterQuery;
- (void)fetchMessages;

@end

NS_ASSUME_NONNULL_END
