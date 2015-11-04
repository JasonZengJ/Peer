//
//  PhoneVerifyView.h
//  Peer
//
//  Created by jason on 11/2/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneVerifyViewDelegate <NSObject>

- (void)clickedGetVerifyCodeButtonWithPhone:(NSString *)phone;

@end

@interface PhoneVerifyView : UIView

@property(nonatomic) UITextField *phoneTextField;
@property(nonatomic) UITextField *verifyCodeTextField;
@property(nonatomic) UITextField *passwordTextField;

@property(nonatomic,weak) id<PhoneVerifyViewDelegate> delegate;


- (void)disableGetVerifyCodeButtonForSeconds:(NSInteger)seconds;

- (void)recoverGetVerifyCodeButton;


@end
