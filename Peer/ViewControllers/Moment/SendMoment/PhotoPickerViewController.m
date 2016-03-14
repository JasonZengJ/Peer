//
//  PhotoPickerViewController.m
//  Peer
//
//  Created by jason on 11/28/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PhotoPickerViewController.h"
#import "SendPhotoMomentViewController.h"

@interface PhotoPickerViewController ()

@end

@implementation PhotoPickerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)rightNavbarButtonAction:(UIButton *)sender {
    SendPhotoMomentViewController *sendPhotoMomentViewController = [[SendPhotoMomentViewController alloc] init];
    
    [self.navigationController pushViewController:sendPhotoMomentViewController animated:YES];
}

- (UIBarButtonItem *)leftBackBarButtonItem {
    
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"SendMomentCancelIcon"];
    
    aButton.frame= CGRectMake(0.0f, 0.0f,ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25));
    [aButton setImage:backImage forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, - 15.0f, 0.0, 0.0)];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    
    return barButton;
}

- (UIBarButtonItem *)rightBarButtonItem {
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    aButton.frame= CGRectMake(-2, 0.0f,ConvertiPhone5Or6pSize(100), ConvertiPhone5Or6pSize(25));
    aButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [aButton setTitle:@"下一步" forState:UIControlStateNormal];
    [aButton setTitleColor:[UIColor colorWithHex:0xFFB600] forState:UIControlStateNormal];
    [aButton addTarget:self action:@selector(rightNavbarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    aButton.width = [aButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:aButton.titleLabel.font}].width;
    self.rightBarButton = aButton;
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    return barButton;
}

- (void)backAction {
    
}

//- (void)cropAction {


    
//}

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
