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

@interface CardCollectionViewCell ()

@property(nonatomic) UILabel *monthLabel;
@property(nonatomic) UILabel *daysLabel;
@property(nonatomic) UIImageView *weatherImageView;
@property(nonatomic) UIImageView *photoImageView;
@property(nonatomic) UIImageView *petsAvatarImageView;
@property(nonatomic) UILabel     *detailsLabel;
@property(nonatomic) UILabel     *contentLabel;
@property(nonatomic) UIImageView *locationIcon;
@property(nonatomic) UILabel     *locationView;

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
    }
    return _photoImageView;
}

- (UIImageView *)petsAvatarImageView {
    if (!_petsAvatarImageView) {
        _petsAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ConvertToiPhone6XYZ(50), ConvertToiPhone6XYZ(50))];
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
        _detailsLabel.font = [UIFont systemFontOfSize:ConvertToiPhone6XYZ(12)];
        _detailsLabel.textColor = [UIColor colorWithHex:0x919191 alpha:1.0];
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.backgroundColor = [UIColor clearColor];
    }
    return _detailsLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.detailsLabel.bottom + 10, self.width - 20, ConvertToiPhone6XYZ(20))];
        _contentLabel.font = [UIFont systemFontOfSize:ConvertToiPhone6XYZ(14)];
        _contentLabel.textColor = [UIColor colorWithHex:0x525252 alpha:1.0];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
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
    self.contentView.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = YES;
    
    [self.contentView addSubview:self.photoImageView];
    [self.contentView addSubview:self.petsAvatarImageView];
    [self.contentView addSubview:self.detailsLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.daysLabel];
    
}

- (void)configureWithMoments:(MomentModel *)momentModel {
    
//    self.daysLabel.text = momentModel.momentTitle;
    self.detailsLabel.text = [NSString stringWithFormat:@"%@－%@－%@个月",@"Duan",@"DD",@"7"];
    self.photoImageView.image = [UIImage imageNamed:@"tmp"];
    self.petsAvatarImageView.image = [UIImage imageNamed:@"avatar"];
    self.contentLabel.text = @"今天把 啊duan 牵了出来溜溜，趁今天天气不错，求约妹子～";
    self.contentLabel.height = [self heightWithString:self.contentLabel.text width:self.contentLabel.width font:self.contentLabel.font];
    
}

- (CGFloat)heightWithString:(NSString *)string width:(CGFloat)width font:(UIFont *)font {
    
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    return [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height;
}

@end
