
#import <Foundation/Foundation.h>

@interface LiftagoSnippetMessageParser: NSObject

- (nullable instancetype)initWithSnippet:(nonnull NSString *)snippet;

@property (nonatomic, copy, readonly) NSString *snippet;

@property (nonatomic, copy, readonly) NSNumber *amount;
@property (nonatomic, copy, readonly) NSString *currency;

- (BOOL)isSuccessfullyParsed;

@end

@interface LiftagoSnippetMessageParserFactory: NSObject

+ (LiftagoSnippetMessageParser *)parserForSnippet:(NSString *)snippet;

@end
