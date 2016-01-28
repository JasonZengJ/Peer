//
//  MineInfoCollectionHeaderView.m
//  Peer
//
//  Created by jason on 1/23/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "MineInfoCollectionHeaderView.h"
#import "UserModel.h"

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


- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 100.0f)];
        _headerView.backgroundColor = [UIColor whiteColor];
        
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
        _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userAvatarImageView.right + 20.0f, self.userAvatarImageView.top, ScreenWidth - self.userAvatarImageView.right, 20.0f)];
        _nickNameLabel.font = [UIFont systemFontOfSize:15.0f];
        _nickNameLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
    }
    return _nickNameLabel;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickNameLabel.right, self.nickNameLabel.bottom + 5.0f, 0, 15.0f)];
        _locationLabel.font = [UIFont systemFontOfSize:11.0f];
        _locationLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
    }
    return _locationLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.locationLabel.right, self.locationLabel.top, 0, 15.0f)];
        _ageLabel.font = [UIFont systemFontOfSize:11.0f];
        _ageLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
    }
    return _ageLabel;
}

- (UIImageView *)sexImageView {
    if (!_sexImageView) {
        _sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.ageLabel.top, 10, 10)];
    }
    return _sexImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    
    
    
    [self addSubview:self.headerView];
    [self addSubview:self.userAvatarImageView];
    
}


@end









