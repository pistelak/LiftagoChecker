
#import "Bill+SnippetMessageParser.h"

#import "BillEntry+CoreDataClass.h"
#import "LiftagoSnippetMessageParser.h"

@implementation Bill (SnippetMessageParser)

- (void)addEntryWithParser:(LiftagoSnippetMessageParser *)parser {
    
    BillEntry *newEntry = [[BillEntry alloc] initWithContext:self.managedObjectContext];
    newEntry.amount = [parser amount];
    newEntry.currency = [parser currency];
    newEntry.snippet = [parser snippet];
    
    [self addEntry:newEntry];
}

@end
