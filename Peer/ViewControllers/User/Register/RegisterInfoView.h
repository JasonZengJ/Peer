//
//  RegisterInfoView.h
//  Peer
//
//  Created by jason on 11/2/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RegisterInfo) {
    RegisterInfoNickname = 1,
    RegisterInfoSex,
    RegisterInfoAge,
    RegisterInfoArea,
    RegisterInfoDescription,
};

typedef NS_ENUM(NSInteger,UserSex) {
    UserSexBoy  = 1,
    UserSexGirl,
};

@protocol  RegisterInfoViewDelegate <NSObject>

- (void)clickedDoneButton;

@optional
- (void)tapCellWithCellTag:(NSInteger)tag;

@end

@interface RegisterInfoView : UIView

@property(nonatomic) UIImageView *userAvatarImageView;
@property(nonatomic,weak) id<RegisterInfoViewDelegate> delegate;

- (void)setUserDescription:(NSString *)userDescription;

- (void)setNickname:(NSString *)nickname;

- (void)setSex:(UserSex)sex;

- (void)setAge:(NSString *)age;

- (void)setArea:(NSString *)area;

@end
