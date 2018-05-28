
#import "BillView.h"

@implementation BillView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
        
        self.spentLabel = [[UILabel alloc] init];
        self.spentLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16];
        self.spentLabel.textColor = [UIColor whiteColor];
        self.spentLabel.textAlignment = NSTextAlignmentCenter;
        self.spentLabel.text = @"Spent";
        [self addSubview:self.spentLabel];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:28];
        self.priceLabel.textColor = [UIColor whiteColor];
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        self.priceLabel.text = @"- Kč";
        [self addSubview:self.priceLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    const CGFloat kPadding = 20;
    const CGFloat kMaxWidth = CGRectGetWidth(self.bounds) - 2 * kPadding;
    
    [self.spentLabel sizeToFit];
    [self.priceLabel sizeToFit];
    
    CGFloat yCoord = kPadding;
    self.spentLabel.frame = CGRectMake(kPadding, yCoord, kMaxWidth, CGRectGetHeight(self.spentLabel.frame));
    yCoord += CGRectGetHeight(self.spentLabel.frame);
    self.priceLabel.frame = CGRectMake(kPadding, yCoord, kMaxWidth, CGRectGetHeight(self.priceLabel.frame));
}

@end
