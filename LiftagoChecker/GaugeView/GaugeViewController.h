//
//  GaugeViewController.h
//  GaugeView
//
//  Created by Radek Pistelak on 11/02/2018.
//  Copyright © 2018 ran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GaugeViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMaxValue:(float)maxValue
                   scaleDivision:(NSUInteger)scaleDivision
                scaleSubdivision:(NSUInteger)scaleSubdivision;

- (void)setValue:(float)value animated:(BOOL)animated;
- (void)setValue:(float)value animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)setValue:(float)value animated:(BOOL)animated duration:(NSTimeInterval)duration;
- (void)setValue:(float)value animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

@end
