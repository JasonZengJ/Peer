//
//  MineInfoCollectionHeaderView.m
//  Peer
//
//  Created by jason on 1/23/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "MineInfoCollectionHeaderView.h"
#import "UserModel.h"
#import "NSString+Size.h"

@interface MineInfoCollectionHeaderView ()


@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) UIImageView *userAvatarImageView;
@property(nonatomic,strong) UILabel *nickNameLabel;
@property(nonatomic,strong) UILabel *locationLabel;
@property(nonatomic,strong) UILabel *ageLabel;
@property(nonatomic,strong) UIImageView *sexImageView;
@property(nonatomic,strong) UILabel *descriptionLabel;


@end

@implementation MineInfoCollectionHeaderView



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    
    [self addSubview:self.headerView];
    
    [self.headerView addSubview:self.userAvatarImageView];
    [self.headerView addSubview:self.nickNameLabel];
    [self.headerView addSubview:self.locationLabel];
    [self.headerView addSubview:self.ageLabel];
    [self.headerView addSubview:self.sexImageView];
    [self.headerView addSubview:self.descriptionLabel];
#warning test
    self.userAvatarImageView.image = [UIImage imageNamed:@"DuanAvatar"];
    
}

- (void)configureWithUserModel:(UserModel *)userModel {
    
    self.nickNameLabel.text = userModel.nickname;
    self.locationLabel.text = [NSString stringWithFormat:@"%@－%@",userModel.city,userModel.area];
    self.ageLabel.text      = [userModel.age stringValue];
    self.descriptionLabel.text = userModel.userDescription;
    
    if (userModel.sex.integerValue == UserSexBoy) {
        self.sexImageView.image = [UIImage imageNamed:@"MineUserSexBoy"];
    } else {
        self.sexImageView.image = [UIImage imageNamed:@"MineUserSexGirl"];
    }
    
}

- (void)layoutSubviews {
    
    self.locationLabel.width = [self.locationLabel.text widthWithFont:self.locationLabel.font];
    self.ageLabel.width = [self.ageLabel.text widthWithFont:self.ageLabel.font];
    self.ageLabel.left  = self.locationLabel.right + 10.0f;
    self.sexImageView.left = self.ageLabel.right + 5.0f;
    self.descriptionLabel.width = self.headerView.width - self.descriptionLabel.left - 20.0f;
    
}


- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 100.0f)];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.layer.shadowColor   = [UIColor blackColor].CGColor;
        _headerView.layer.shadowOffset  = CGSizeMake(0.0, 0.0);
        _headerView.layer.shadowOpacity = 0.1;
        _headerView.layer.cornerRadius = 3;
    }
    return _headerView;
}

- (UIImageView *)userAvatarImageView {
    if (!_userAvatarImageView) {
        _userAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60.0f, 60.0f)];
        _userAvatarImageView.clipsToBounds = YES;
        _userAvatarImageView.layer.cornerRadius = _userAvatarImageView.width / 2.0;
    }
    return _userAvatarImageView;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userAvatarImageView.right + 20.0f, self.userAvatarImageView.top , ScreenWidth - self.userAvatarImageView.right, 20.0f)];
        _nickNameLabel.font = [UIFont systemFontOfSize:15.0f];
        _nickNameLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
        _nickNameLabel.height = [@"" heightWithFont:_nickNameLabel.font width:_nickNameLabel.width];
    }
    return _nickNameLabel;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickNameLabel.left, self.nickNameLabel.bottom + 3.0f, 0, 15.0f)];
        _locationLabel.font = [UIFont systemFontOfSize:11.0f];
        _locationLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
    }
    return _locationLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.locationLabel.right, self.locationLabel.top, 0, 15.0f)];
        _ageLabel.font = [UIFont systemFontOfSize:12.0f];
        _ageLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
    }
    return _ageLabel;
}

- (UIImageView *)sexImageView {
    if (!_sexImageView) {
        _sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.ageLabel.top, 10, 10)];
        _sexImageView.centerY = self.ageLabel.centerY;
    }
    return _sexImageView;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickNameLabel.left, self.locationLabel.bottom + 3.0f, 0, 16.0f)];
        _descriptionLabel.font = [UIFont systemFontOfSize:13.0f];
        _descriptionLabel.textColor = [UIColor colorWithHex:0x999999];
    }
    return _descriptionLabel;
}

@end









