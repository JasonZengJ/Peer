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
