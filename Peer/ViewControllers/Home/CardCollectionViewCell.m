//
//  CardCollectionViewCell.m
//  Peer
//
//  Created by jason on 10/16/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "CardCollectionViewCell.h"
#import "MomentModel.h"
#import "UIColor+Hex.h"
#import "UIView+Layout.h"
#import "LayoutUtil.h"
#import "NSString+Size.h"

@interface CardCollectionViewCell ()

@property(nonatomic) UILabel *monthLabel;
@property(nonatomic) UILabel *daysLabel;
@property(nonatomic) UIImageView *weatherImageView;
@property(nonatomic) UIImageView *photoImageView;
@property(nonatomic) UIImageView *petsAvatarImageView;
@property(nonatomic) UILabel     *detailsLabel;
@property(nonatomic) UILabel     *contentLabel;

@property(nonatomic) UIView      *bottomView;
@property(nonatomic) UIImageView *locationIcon;
@property(nonatomic) UILabel     *locationLabel;

@property(nonatomic) UIImageView *commentsIcon;
@property(nonatomic) UILabel     *commentsAmountLabel;
@property(nonatomic) UIImageView *likeImageView;

@end

@implementation CardCollectionViewCell


- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _monthLabel;
}

- (UILabel *)daysLabel {
    if (!_daysLabel) {
        _daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 100)];
        _daysLabel.backgroundColor = [UIColor clearColor];
    }
    return _daysLabel;
}

- (UIImageView *)photoImageView {
    
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 1.2)];
//        _photoImageView.autoresizingMask  = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _photoImageView;
}

- (UIImageView *)petsAvatarImageView {
    if (!_petsAvatarImageView) {
        _petsAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ConvertiPhone5Or6pSize(55), ConvertiPhone5Or6pSize(55))];
        _petsAvatarImageView.layer.cornerRadius = _petsAvatarImageView.width / 2;
        _petsAvatarImageView.clipsToBounds = YES;
        _petsAvatarImageView.centerX = self.photoImageView.centerX;
        _petsAvatarImageView.centerY = self.photoImageView.bottom;
        _petsAvatarImageView.layer.borderWidth = 2;
        _petsAvatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _petsAvatarImageView;
}

- (UILabel *)detailsLabel {
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.petsAvatarImageView.bottom + 3, self.width, ConvertToiPhone6XYZ(20))];
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
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(10,  self.height - ConvertiPhone5Or6pSize(35), self.width - 20, ConvertiPhone5Or6pSize(35.0f))];
        [_bottomView addLineWithFrame:CGRectMake(10, 0 , _bottomView.width, 0.5) border:UIViewBorderBottomLine];
    }
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
        _locationLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(12)];
        _locationLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1.0];
    }
    return _locationLabel;
}

- (UIImageView *)commentsIcon {
    if (!_commentsIcon) {
        _commentsIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomeComments"]];
        _commentsIcon.width  = ConvertiPhone5Or6pSize(15.0);
        _commentsIcon.height = ConvertiPhone5Or6pSize(15.0);
        _commentsIcon.centerY = self.locationIcon.centerY;
    }
    return _commentsIcon;
}

- (UILabel *)commentsAmountLabel {
    if (!_commentsAmountLabel) {
        _commentsAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.commentsIcon.right, 0, 140, self.bottomView.height)];
        _commentsAmountLabel.font = self.locationLabel.font;
        _commentsAmountLabel.text = @"0";
        _commentsAmountLabel.textColor = self.locationLabel.textColor;
        
    }
    return _commentsAmountLabel;
}

- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bottomView.width - ConvertiPhone5Or6pSize(25), 0, ConvertiPhone5Or6pSize(25), ConvertiPhone5Or6pSize(25))];
        _likeImageView.centerY = self.bottomView.height / 2;
        _likeImageView.userInteractionEnabled = YES;
        [_likeImageView addTapGestureWithTarget:self action:@selector(tapLikePets)];
    }
    return _likeImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.borderWidth = 1.0f;
    self.contentView.layer.borderColor = [UIColor colorWithHex:0xe1e1e1 alpha:1.0].CGColor;
    self.contentView.layer.cornerRadius = 4;
    self.contentView.clipsToBounds = YES;
    
    [self.contentView addSubview:self.photoImageView];
    [self.contentView addSubview:self.petsAvatarImageView];
    [self.contentView addSubview:self.detailsLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.daysLabel];
    [self.contentView addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.locationIcon];
    [self.bottomView addSubview:self.locationLabel];
    [self.bottomView addSubview:self.commentsIcon];
    [self.bottomView addSubview:self.commentsAmountLabel];
    [self.bottomView addSubview:self.likeImageView];
    
    
    
}

- (void)configureWithMoments:(MomentModel *)momentModel {
    
//    self.daysLabel.text = momentModel.momentTitle;
    self.detailsLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@个月",@"Duan",@"DD",@"7"];
    self.photoImageView.image = [UIImage imageNamed:@"tmp"];
    self.petsAvatarImageView.image = [UIImage imageNamed:@"avatar"];
    self.contentLabel.text = @"今天把 啊duan 牵了出来溜溜，趁今天天气不错，求约妹子～";
    self.contentLabel.height = [self.contentLabel.text sizeWithFont:self.contentLabel.font constraintsSize:CGSizeMake(self.contentLabel.width, 45.0f)].height;
    
    self.locationLabel.text = [NSString stringWithFormat:@"%@ - %@",@"广州",@"白云"];
    self.locationLabel.width = [self.locationLabel.text sizeWithFont:self.locationLabel.font constraintsSize:CGSizeMake(self.width, self.bottomView.height)].width;
    
    self.commentsAmountLabel.text  = @"88";
    self.commentsIcon.left = self.locationLabel.right + 10;
    self.commentsAmountLabel.left = self.commentsIcon.right + 3;
    
    self.likeImageView.image = [UIImage imageNamed:@"HomeUnlikeHeart"];
    
    
}


- (void)tapLikePets {
    
    self.likeImageView.image = [UIImage imageNamed:@"HomeLikeHeart"];
    
}

- (CGFloat)heightWithString:(NSString *)string size:(CGSize)size font:(UIFont *)font {
    
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height;
}

@end
