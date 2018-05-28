
#import "NetworkController.h"
#import "LiftagoSnippetMessageParser.h"
#import "Bill+CoreDataProperties.h"
#import "Bill+SnippetMessageParser.h"
#import "BillEntry+CoreDataClass.h"
#import "NSManagedObject+FindOrCreate.h"
#import "GMailFilterQueryProvider.h"
#import <GMailService/GMailService.h>
#import <FoundationUtils/NSObject+Blocks.h>
#import <Google/SignIn.h>

@interface NetworkController()

@property (nonatomic, strong) GIDSignIn *signInService;
@property (nonatomic, strong) GMailMessageFetcher *messageFetcher;
@property (nonatomic, strong) NSManagedObjectContext *mainContext;

@property (nonatomic, copy) NetworkControllerCompletionHandler completionBlock;

@end

@implementation NetworkController

- (instancetype)initWithSignInService:(GIDSignIn *)signInService
                       messageFetcher:(GMailMessageFetcher *)messageFetcher
                  persistentContainer:(NSPersistentContainer *)container {
    self = [super init];
    if (self) {
        _messageFetcher = messageFetcher;
        _signInService = signInService;
        _mainContext = [container viewContext];
    }
    return self;
}

#pragma mark - Public

- (NSFetchedResultsController *)loadBillWithCompletionHandler:(NetworkControllerCompletionHandler)handler {
    
    [self updateBillWithCopletionHandler:handler];
    
    return [self fetchedResultsController];
}

- (void)updateBillWithCopletionHandler:(NetworkControllerCompletionHandler)handler {
    [self updateAuthorization];
    
    self.completionBlock = handler;
    
    __weak typeof(self) welf = self;
    
    [self.messageFetcher fetchMessagesWithFilterQuery:[self.filterQueryProvider query] success:^(NSArray *messages) {
        [welf updateMessages:messages];
    } failure:^(NSError *error) {
        [welf performBlock:welf.completionBlock withObject:error];
        [welf setCompletionBlock:nil];
    }];
}

#pragma mark - GMailServiceDelegate

- (NSUInteger)currentMonth {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:[NSDate date]];
}

- (void)updateMessages:(NSArray *)messages {
    
    // TODO: move this
    self.mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    
    Bill *bill = [Bill findOrCreateWithSelectorAsPrimaryKey:@selector(monthIndex)
                                                      value:@([self currentMonth])
                                                  inContext:self.mainContext];
    
    for (NSString *snippet in [messages valueForKey:@"snippet"]) {
        [bill addEntryWithParser:[LiftagoSnippetMessageParserFactory parserForSnippet:snippet]];
    }
    
    __weak typeof(self) welf = self;
    
    [self.mainContext performBlock:^{
        [self.mainContext save:nil];
        [welf performBlock:welf.completionBlock withObject:nil];
        [welf setCompletionBlock:nil];
    }];
}

#pragma mark - Private

- (void)updateAuthorization {
    self.messageFetcher.authorization = [self.signInService.currentUser.authentication fetcherAuthorizer];
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    id fetchRequest = [Bill fetchRequestForBillWithMonthIndex:[self currentMonth]];
    [fetchRequest setSortDescriptors:@[ [NSSortDescriptor sortDescriptorWithKey:@"monthIndex" ascending:YES] ]];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                               managedObjectContext:self.mainContext
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

@end
