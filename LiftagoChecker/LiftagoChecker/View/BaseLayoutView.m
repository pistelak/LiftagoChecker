
#import "BaseLayoutView.h"

@implementation BaseLayoutView

- (instancetype)init {
    self = [super init];
    if (self) {

        self.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:24];
        self.titleLabel.textColor = [UIColor colorWithRed:0.33 green:0.36 blue:0.40 alpha:1.00];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = @"Liftago";
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setOverview:(UIView *)overview {
    _overview = overview;
    _overview.backgroundColor = self.backgroundColor;
}

- (void)setStateView:(UIView *)stateView {
    _stateView = stateView;
    _stateView.backgroundColor = [UIColor colorWithRed:0.48 green:0.77 blue:0.87 alpha:1.00];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    const CGFloat kPadding = 20;
    const CGFloat kMaxWidth = CGRectGetWidth(self.bounds);
    const CGFloat kOverviewDiameter = kMaxWidth - 2 * kPadding;
    
    [self.titleLabel sizeToFit];

    self.titleLabel.frame = CGRectMake(
       0,
       2 * kPadding,
       kMaxWidth,
       CGRectGetHeight(self.titleLabel.frame)
    );
    
    self.overview.frame = CGRectMake(
      self.center.x - kOverviewDiameter/2,
      0.16 * CGRectGetHeight(self.bounds),
      kOverviewDiameter,
      kOverviewDiameter
    );
    
    self.stateView.frame = CGRectMake(
      0,
      CGRectGetMaxY(self.overview.frame) + 2 * kPadding,
      kMaxWidth,
      CGRectGetHeight(self.bounds) - CGRectGetMaxY(self.overview.frame) - 2 * kPadding
    );
}

@end
