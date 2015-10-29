//
//  RootNavViewController.h
//  Peer
//
//  Created by jason on 10/25/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BackActionType) {
    BackActionTypePop = 1,
    BackActionTypeDismiss,
};

@interface RootNavViewController : UIViewController


@property(nonatomic,assign)BackActionType backActionType;

- (UIBarButtonItem *)rightBarButtonItem;

- (UIBarButtonItem *)leftBackBarButtonItem;

- (void)backButtonAction:(UIButton *)sender;

- (void)rightNavbarButtonAction:(UIButton *)sender;

@end
