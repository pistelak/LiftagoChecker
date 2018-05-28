
#import <Foundation/Foundation.h>

@protocol GMailFilterQueryProvider;
@class NSFetchedResultsController, NSPersistentContainer, GIDSignIn, GMailMessageFetcher;

typedef void(^NetworkControllerCompletionHandler)(NSError *error);

@interface NetworkController : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSignInService:(GIDSignIn *)signInService
                       messageFetcher:(GMailMessageFetcher *)messageFetcher
                  persistentContainer:(NSPersistentContainer *)container;

@property (nonatomic, strong) id<GMailFilterQueryProvider> filterQueryProvider;

- (void)updateBillWithCopletionHandler:(NetworkControllerCompletionHandler)handler;
- (NSFetchedResultsController *)loadBillWithCompletionHandler:(NetworkControllerCompletionHandler)handler;

@end
