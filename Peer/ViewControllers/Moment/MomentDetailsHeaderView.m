//
//  MomentDetailsHeaderView.m
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentDetailsHeaderView.h"
#import "MomentModel.h"
#import "NSString+Size.h"
#import <UIImageView+AFNetworking.h>

@interface MomentDetailsHeaderView ()

@property(nonatomic) MomentModel *momentModel;

@property(nonatomic) UIImageView *photoImageView;
@property(nonatomic) UIImageView *petsAvatarImageView;


@property(nonatomic) UILabel     *detailsLabel;
@property(nonatomic) UILabel     *contentLabel;

@property(nonatomic) UIView      *bottomView;
@property(nonatomic) UIImageView *locationIcon;
@property(nonatomic) UILabel     *locationLabel;
@property(nonatomic) UIImageView *weatherImageView;
@property(nonatomic) UILabel     *dateLabel;

@property(nonatomic) UIView      *LikedUsersView;
@property(nonatomic) UIImageView *likeImageView;

@property(nonatomic) UILabel     *toBeFirstLikeLabel;

@end

@implementation MomentDetailsHeaderView

- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 1.2)];
    }
    return _photoImageView;
}


- (UIImageView *)petsAvatarImageView {
    if (!_petsAvatarImageView) {
        _petsAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(55), ConvertiPhone5Or6pSize(55))];
        _petsAvatarImageView.backgroundColor =[UIColor clearColor];
        _petsAvatarImageView.clipsToBounds = YES;
        _petsAvatarImageView.centerX = self.photoImageView.centerX;
        _petsAvatarImageView.centerY = self.photoImageView.bottom;
        _petsAvatarImageView.layer.cornerRadius = _petsAvatarImageView.width / 2;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(59), ConvertiPhone5Or6pSize(59))];
        view.backgroundColor = [UIColor whiteColor];
        view.center = _petsAvatarImageView.center;
        view.layer.cornerRadius = view.width / 2;
        [self addSubview:view];
    }
    
    return _petsAvatarImageView;
}


- (UILabel *)detailsLabel {
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.petsAvatarImageView.bottom + 5, self.width, ConvertToiPhone6XYZ(20))];
        _detailsLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(12)];
        _detailsLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1.0];
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.backgroundColor = [UIColor clearColor];
    }
    return _detailsLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.detailsLabel.bottom + 10, self.width - 20, ConvertToiPhone6XYZ(20))];
        _contentLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(15)];
        _contentLabel.textColor = [UIColor colorWithHex:0x4c4c4c alpha:1.0];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(10,  self.height - ConvertiPhone5Or6pSize(30.0f), self.width - 20, ConvertiPhone5Or6pSize(30.0f))];
    }
    [_bottomView addLineWithFrame:CGRectMake(0, _bottomView.height - 0.5 , _bottomView.width, 0.5) border:UIViewBorderBottomLine];
    return _bottomView;
}

- (UIImageView *)locationIcon {
    if (!_locationIcon) {
        _locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomeLocation"]];
        _locationIcon.width  = ConvertiPhone5Or6pSize(15.0);
        _locationIcon.height = ConvertiPhone5Or6pSize(15.0);
        _locationIcon.centerY = self.bottomView.height / 2;
    }
    return _locationIcon;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.locationIcon.right + 3, 0, 0, self.bottomView.height)];
        _locationLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(11)];
        _locationLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1.0];
    }
    return _locationLabel;
}

- (UIImageView *)weatherImageView {
    if (!_weatherImageView) {
        _weatherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.locationLabel.right + 15, 0, ConvertiPhone5Or6pSize(20), ConvertiPhone5Or6pSize(20))];
        _weatherImageView.centerY = self.bottomView.height / 2;
    }
    return _weatherImageView;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.bottomView.height)];
        _dateLabel.font = self.locationLabel.font;
        _dateLabel.textColor = self.locationLabel.textColor;
    }
    return _dateLabel;
}

- (UIView *)LikedUsersView {
    if (!_LikedUsersView) {
        _LikedUsersView = [[UIView alloc] initWithFrame:CGRectMake(10, self.bottomView.bottom, self.width - 20, ConvertiPhone5Or6pSize(40.0f))];
    }
    return _LikedUsersView;
}

- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.LikedUsersView.width - ConvertiPhone5Or6pSize(30), 0, ConvertiPhone5Or6pSize(30), ConvertiPhone5Or6pSize(30))];
        _likeImageView.centerY = self.LikedUsersView.height / 2;
        _likeImageView.userInteractionEnabled = YES;
        [_likeImageView addTapGestureWithTarget:self action:@selector(tapLikePets)];
    }
    return _likeImageView;
}



- (UILabel *)toBeFirstLikeLabel {
    if (!_toBeFirstLikeLabel) {
        
    }
    return _toBeFirstLikeLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self addSubview:self.photoImageView];
    [self addSubview:self.petsAvatarImageView];
    [self addSubview:self.detailsLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.bottomView];
    [self addSubview:self.LikedUsersView];
    
    [self.bottomView addSubview:self.locationIcon];
    [self.bottomView addSubview:self.locationLabel];
    [self.bottomView addSubview:self.weatherImageView];
    [self.bottomView addSubview:self.dateLabel];
    
    [self.LikedUsersView addSubview:self.likeImageView];
    
    self.height = self.LikedUsersView.bottom;
}

- (void)layoutSubviews {
    
}

- (void)configureWithMomentModel:(MomentModel *)momentModel {
    
    
#warning Test
    
    momentModel.createdAt = @"9月25日 12:33:33";
    
#warning Test
    
    self.momentModel = momentModel;
    if ([momentModel.momentType integerValue] == 1) {
        [self.photoImageView setImageWithURL:[NSURL URLWithString:momentModel.momentTargetUrl]];
    }
    
    self.detailsLabel.text         = [NSString stringWithFormat:@"%@ - %@ - %@个月",@"Duan",@"DD",@"7"];
    self.petsAvatarImageView.image = [UIImage imageNamed:@"avatar"];
    
    self.contentLabel.text   = momentModel.momentDescription;
    self.contentLabel.height = [self.contentLabel.text heightWithFont:self.contentLabel.font width:self.contentLabel.width];
    
    self.locationLabel.text  = [NSString stringWithFormat:@"%@ - %@",@"广州",@"白云"];
    self.locationLabel.width = [self.locationLabel.text sizeWithFont:self.locationLabel.font constraintsSize:CGSizeMake(self.width, self.bottomView.height)].width;
    
    self.weatherImageView.image = [UIImage imageNamed:@"晴"];
    self.weatherImageView.left  = self.locationLabel.right + 15;
    
    self.dateLabel.text = momentModel.createdAt;
    self.dateLabel.left = self.weatherImageView.right + 10;
    
    self.likeImageView.image = [UIImage imageNamed:@"MomentDetailsLikeHeart"];
    
}

- (void)configureLikedUsersAvatarWithArray:(NSArray *)likedUsersAvatarUrlArray {
   
    
#warning Test
    
    self.momentModel.likeAmount = @(43);
    likedUsersAvatarUrlArray = @[@{},@{},@{},@{},@{},@{}];
    
#warning Test
    
    
    CGFloat left = 0;
    
    for (NSDictionary *dataDic in likedUsersAvatarUrlArray) {
        
        UIImageView *userAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, 0, ConvertiPhone5Or6pSize(30.0), ConvertiPhone5Or6pSize(30.0))];
        userAvatarImageView.image              = [UIImage imageNamed:@"avatar"];
        userAvatarImageView.centerY            = self.LikedUsersView.height / 2;
        userAvatarImageView.clipsToBounds      = YES;
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.width / 2;
        
        left = userAvatarImageView.right + 5;
        [self.LikedUsersView addSubview:userAvatarImageView ];
        
    }
    
    if ([self.momentModel.likeAmount integerValue] > 6) {
        
        UILabel *likedUserAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, ConvertiPhone5Or6pSize(30.0), ConvertiPhone5Or6pSize(30.0))];
        likedUserAmountLabel.text               = self.momentModel.likeAmount.stringValue;
        likedUserAmountLabel.font               = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(11)];
        likedUserAmountLabel.textColor          = [UIColor colorWithHex:0x808080 alpha:1.0];
        likedUserAmountLabel.backgroundColor    = [UIColor colorWithHex:0xe6e6e6 alpha:1.0];
        likedUserAmountLabel.layer.cornerRadius = likedUserAmountLabel.width / 2;
        likedUserAmountLabel.clipsToBounds      = YES;
        likedUserAmountLabel.textAlignment      = NSTextAlignmentCenter;
        likedUserAmountLabel.centerY            = self.LikedUsersView.height / 2;
        [self.LikedUsersView addSubview:likedUserAmountLabel];
        
        
    }
    
}

- (void)tapUserAvatar {
    
}

- (void)tapLikePets {
    
}

@end
