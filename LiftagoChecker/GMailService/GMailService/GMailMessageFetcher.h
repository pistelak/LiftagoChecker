//
//  GMailMessageFetcher.h
//  LiftagoChecker
//
//  Created by Radek Pistelak on 09/09/2017.
//  Copyright © 2017 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GTMFetcherAuthorizationProtocol, GMailFilterQuery, GTLRGmail_Message;

@interface GMailMessageFetcher : NSObject

@property (nonatomic, strong) id<GTMFetcherAuthorizationProtocol> authorization;

- (void)fetchMessagesWithFilterQuery:(id<GMailFilterQuery>)filterQuery
                             success:(void(^)(NSArray *messages))successHandler
                             failure:(void(^)(NSError *error))failureHandler;

@end
