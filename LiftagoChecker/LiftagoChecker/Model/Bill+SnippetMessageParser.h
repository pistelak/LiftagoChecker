
#import "Bill+CoreDataClass.h"

@class LiftagoSnippetMessageParser;

@interface Bill (SnippetMessageParser)

- (void)addEntryWithParser:(LiftagoSnippetMessageParser *)parser;

@end
