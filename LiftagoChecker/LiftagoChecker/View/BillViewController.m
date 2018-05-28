
#import "BillViewController.h"
#import "BillView.h"
#import "Bill+CoreDataClass.h"

@import GaugeView;
@import FoundationUtils;

@interface BillViewController()

@property (nonatomic, strong) BillView *view;

@end

@implementation BillViewController

@dynamic view;

- (void)loadView {
    self.view = [[BillView alloc] init];
}

- (void)displayBill:(Bill *)bill {
    [self.view.priceLabel setText:[bill formattedValue]];
}

@end
