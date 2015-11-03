//
//  RegisterInfoView.h
//  Peer
//
//  Created by jason on 11/2/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,RegisterInfoCell) {
    RegisterInfoCellNickname = 1,
    RegisterInfoCellSex,
    RegisterInfoCellAge,
    RegisterInfoCellArea,
};

typedef NS_ENUM(NSInteger,UserSex) {
    UserSexBoy  = 1,
    UserSexGirl,
};

@protocol  RegisterInfoViewDelegate <NSObject>


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
