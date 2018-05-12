/*
 * WMGaugeView.h
 *
 * Copyright (C) 2014 William Markezana <william.markezana@me.com>
 *
 
 License
 
 WMGaugeView is available under the MIT license.
 
 Copyright © 2014 William Markezana.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import <UIKit/UIKit.h>
#import "WMGaugeViewStyle.h"
#import "WMGaugeViewStyleFlatThin.h"

/**
 * Styling enumerations
 */
typedef enum
{
    WMGaugeViewSubdivisionsAlignmentTop,
    WMGaugeViewSubdivisionsAlignmentCenter,
    WMGaugeViewSubdivisionsAlignmentBottom
}
WMGaugeViewSubdivisionsAlignment;

/**
 * WMGaugeView class
 */
@interface WMGaugeView : UIView

/**
 * WMGaugeView properties
 */
@property (nonatomic, readwrite, assign) bool showInnerBackground;
@property (nonatomic, readwrite, assign) bool showInnerRim;
@property (nonatomic, readwrite, assign) CGFloat innerRimWidth;
@property (nonatomic, readwrite, assign) CGFloat innerRimBorderWidth;
@property (nonatomic, readwrite, assign) CGFloat scalePosition;
@property (nonatomic, readwrite, assign) CGFloat scaleStartAngle;
@property (nonatomic, readwrite, assign) CGFloat scaleEndAngle;
@property (nonatomic, readwrite, assign) CGFloat scaleDivisions;
@property (nonatomic, readwrite, assign) CGFloat scaleSubdivisions;
@property (nonatomic, readwrite, assign) bool showScaleShadow;
@property (nonatomic, readwrite, assign) bool showScale;
@property (nonatomic, readwrite, assign) WMGaugeViewSubdivisionsAlignment scalesubdivisionsAligment;
@property (nonatomic, readwrite, assign) CGFloat scaleDivisionsLength;
@property (nonatomic, readwrite, assign) CGFloat scaleDivisionsWidth;
@property (nonatomic, readwrite, assign) CGFloat scaleSubdivisionsLength;
@property (nonatomic, readwrite, assign) CGFloat scaleSubdivisionsWidth;
@property (nonatomic, readwrite, strong) UIColor *scaleDivisionColor;
@property (nonatomic, readwrite, strong) UIColor *scaleSubDivisionColor;
@property (nonatomic, readwrite, strong) UIFont *scaleFont;
@property (nonatomic, readwrite, assign) float value;
@property (nonatomic, readwrite, assign) float minValue;
@property (nonatomic, readwrite, assign) float maxValue;
@property (nonatomic, readwrite, assign) bool showRangeLabels;
@property (nonatomic, readwrite, assign) CGFloat rangeLabelsWidth;
@property (nonatomic, readwrite, strong) UIFont *rangeLabelsFont;
@property (nonatomic, readwrite, strong) UIColor *rangeLabelsFontColor;
@property (nonatomic, readwrite, assign) CGFloat rangeLabelsFontKerning;
@property (nonatomic, readwrite, strong) NSArray *rangeValues;
@property (nonatomic, readwrite, strong) NSArray *rangeColors;
@property (nonatomic, readwrite, strong) NSArray *rangeLabels;
@property (nonatomic, readwrite, strong) UIColor *unitOfMeasurementColor;
@property (nonatomic, readwrite, assign) CGFloat unitOfMeasurementVerticalOffset;
@property (nonatomic, readwrite, strong) UIFont *unitOfMeasurementFont;
@property (nonatomic, readwrite, strong) NSString *unitOfMeasurement;
@property (nonatomic, readwrite, assign) bool showUnitOfMeasurement;
@property (nonatomic, readwrite, strong) id<WMGaugeViewStyle> style;

/**
 * WMGaugeView public functions
 */
- (void)setValue:(float)value animated:(BOOL)animated;
- (void)setValue:(float)value animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)setValue:(float)value animated:(BOOL)animated duration:(NSTimeInterval)duration;
- (void)setValue:(float)value animated:(BOOL)animated duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

@end
