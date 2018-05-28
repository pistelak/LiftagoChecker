
#import "LoginViewController.h"
#import "LoginView.h"
#import "BaseLayoutView.h"
#import "GaugeViewController+FactoryMethod.h"
#import "UIViewController+Containment.h"

@interface LoginViewController ()

@property (nonatomic, strong) GaugeViewController *gaugeViewController;
@property (nonatomic, strong) BaseLayoutView *view;
@property (nonatomic, strong) LoginView *loginView;

@end

@implementation LoginViewController

@dynamic view;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.gaugeViewController = [GaugeViewController liftagoGaugeViewController];
    }
    return self;
}

- (void)loadView {
    self.view = [[BaseLayoutView alloc] init];
    self.loginView = [[LoginView alloc] init];
    self.view.stateView = self.loginView;
    [self.view addSubview:self.loginView];
    
    [self addContentViewController:[self gaugeViewController] viewSelectorForContentView:@selector(overview)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginView.loginButton addTarget:self action:@selector(loginButtonTapped) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions

- (void)loginButtonTapped {
    [self.delegate loginViewControllerDidSelectLogin:self];
}

@end
