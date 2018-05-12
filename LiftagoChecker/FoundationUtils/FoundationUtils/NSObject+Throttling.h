//
//  NSObject+Throttling.h
//  FoundationUtils
//
//  Created by Radek Pistelak on 03/03/2018.
//  Copyright © 2018 Radek Pistelak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Throttling)

/**
 This method allows you to limit the number of messages to the first one for given interval.

 See the next diagram.
 
           1.message  2.message         3.message     4.message
            (sent)    (ignored)         (ignored)       (sent)
    ─ ─ ─ ─ ─ @ ─ ─ ─ ─ @ ─ ─ ─ ─ ─ ─ ─ ─ ─@─ ─ ┬ ─ ─ ─ ─ @ ─ ─ ─▶
              │                                 |         |      t
              |        ┌───────────────┐        │         |
              └ ─ ─ ─ ─│  an interval  │─ ─ ─ ─▶          └─ ─ ─ ─
                       └───────────────┘
 
 @param selector A selector identifying the message to send.
 @param anObject An object that is the sole argument of the message.
 @param anInterval An interval determines how long the throttling longs.
*/
- (void)performSelector:(SEL)selector
             withObject:(id)anObject
       throttleInterval:(NSTimeInterval)anInterval;

/**
 This method allows you to limit the number of messages to the first one (and optionally for the last one) for given interval.
 
 See the next diagram.
 
          1.message  2.message          3.message             4.message
            (sent)   (ignored)   (depends on `performLast`)     (sent)
               |         |                  |         _ _ _ _ _ _ |
               |         |                  |        /
     ─ ─ ─ ─ ─ @ ─ ─ ─ ─ @ ─ ─ ─ ─ ─ ─ ─ ─ ─@─ ─ X ─ @ ─ ─ ─ ─ ─ ─▶
               │                                 |   |           t
               |        ┌───────────────┐        │   |
               └ ─ ─ ─ ─│  an interval  │─ ─ ─ ─▶    └ ─ ─ ─
                        └───────────────┘
 
 @param selector A selector identifying the message to send.
 @param anObject An object that is the sole argument of the message.
 @param anInterval An interval determines how long the throttling longs.
 @param performLast When performLast is `YES` the last message is sent at the trailing edge of given interval.
*/
- (void)performSelector:(SEL)selector
             withObject:(id)anObject
       throttleInterval:(NSTimeInterval)anInterval
            performLast:(BOOL)performLast;


/**
 This method allows you to limit the number of messages to the last one for given interval. (TODO: Write better description.)
 
 See the next diagram.

         1.message   2.message
         (ignored)  (sent in X)
    ─ ─ ─ ─ @ ─ ─ ─ ─ ─ @ ─ ─ ─ ─ ─ ─ ─ ─ X ─ ─ ─ ─ ─ ─▶
            |           │                 |            t
            |           |  ┌───────────┐  │
            └ ─ ─ ─ ─ X └ ─│an interval│ ─▶
                           └───────────┘

 @param selector A selector identifying the message to send.
 @param anObject An object that is the sole argument of the message.
 @param anInterval An interval determines how long we should wait for the next message.
*/
- (void)performSelector:(SEL)selector
             withObject:(id)anObject
       debounceInterval:(NSTimeInterval)anInterval;

@end
