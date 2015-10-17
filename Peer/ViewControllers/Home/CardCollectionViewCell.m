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


- (UILabel *)daysLabel {
    if (!_daysLabel) {
        _daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 100)];
        _daysLabel.backgroundColor = [UIColor clearColor];
    }
    return _daysLabel;
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
    self.contentView.layer.cornerRadius = 3;
    
    [self.contentView addSubview:self.daysLabel];
}

- (void)configureWithMoments:(MomentModel *)momentModel {
    
    self.daysLabel.text = momentModel.momentTitle;
    
}

@end
