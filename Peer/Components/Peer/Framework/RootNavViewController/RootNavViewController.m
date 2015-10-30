//
//  RootNavViewController.m
//  Peer
//
//  Created by jason on 10/25/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "RootNavViewController.h"

@implementation RootNavViewController

- (UIView *)navbarBgView {
    if (!_navbarBgView) {
        _navbarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64.0f)];
        _navbarBgView.backgroundColor = [UIColor colorWithHex:0xfafafa alpha:1.0];
    }
    return _navbarBgView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backActionType = BackActionTypePop;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.navigationItem.leftBarButtonItem  = [self leftBackBarButtonItem];
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    self.view.backgroundColor = [UIColor colorWithHex:0xfafafa alpha:1.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIBarButtonItem *)rightBarButtonItem {
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.titleEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    UIImage *backImage = [UIImage imageNamed:@"MomentDetailsMoreOption"];
    aButton.frame= CGRectMake(-2, 0.0f,ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25));
    [aButton setImage:backImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(rightNavbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    return barButton;
}

- (UIBarButtonItem *)leftBackBarButtonItem {
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.titleEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    UIImage *backImage = [UIImage imageNamed:@"MomentDetailsLeftArrow"];
    aButton.frame= CGRectMake(-2, 0.0f,ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25));
    [aButton setImage:backImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    return barButton;
}


- (void)backButtonAction:(UIButton *)sender {
    
    if (self.backActionType == BackActionTypeDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (self.backActionType == BackActionTypePop)  {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)rightNavbarButtonAction:(UIButton *)sender {
    
}

@end
