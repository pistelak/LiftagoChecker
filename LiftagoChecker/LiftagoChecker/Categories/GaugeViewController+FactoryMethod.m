
#import "GaugeViewController+FactoryMethod.h"

@implementation GaugeViewController (FactoryMethod)

+ (GaugeViewController *)liftagoGaugeViewController {
    
    const NSUInteger kMaxDisplayableBillValue = 3500; // CZK
    const NSUInteger kScaleDivisionValue = 500;       // CZK
    const NSUInteger kScaleSubvisionValue = 100;      // CZK
    const NSUInteger kScaleDivision = kMaxDisplayableBillValue / kScaleDivisionValue;
    const NSUInteger kScaleSubdivision = kScaleDivisionValue / kScaleSubvisionValue;
    
    return [[GaugeViewController alloc]
            initWithMaxValue:kMaxDisplayableBillValue
            scaleDivision:kScaleDivision
            scaleSubdivision:kScaleSubdivision];
}

@end
