//
//  PhoneVerifyViewController.m
//  Peer
//
//  Created by jason on 9/18/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PhoneVerifyViewController.h"
#import "PhoneVerifyView.h"

#import "RegisterInfoViewController.h"

@interface PhoneVerifyViewController ()

@property(nonatomic)PhoneVerifyView *phoneVerifyView;

@end

@implementation PhoneVerifyViewController


- (PhoneVerifyView *)phoneVerifyView {
    if (!_phoneVerifyView) {
        _phoneVerifyView = [[PhoneVerifyView alloc] initWithFrame:CGRectMake(0, 64.0f, self.view.width, self.view.height - 64.0f)];
        _phoneVerifyView.backgroundColor = [UIColor clearColor];
    }
    return _phoneVerifyView;
}

- (void)loadView {
    [super loadView];
    self.title = @"注册";
    [self.view addSubview:self.phoneVerifyView];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (UIBarButtonItem *)rightBarButtonItem {
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.titleEdgeInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    UIImage *backImage = [UIImage imageNamed:@"UserRegisterNextStep"];
    aButton.frame= CGRectMake(-2, 0.0f,ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25));
    [aButton setImage:backImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(rightNavbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    return barButton;
    
}

- (void)rightNavbarButtonAction:(UIButton *)sender {
    
    RegisterInfoViewController *registerInfoViewController = [[RegisterInfoViewController alloc] init];
    registerInfoViewController.backActionType = BackActionTypePop;
    [self.navigationController pushViewController:registerInfoViewController animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
