//
//  MineCardCollectionViewCell.m
//  Peer
//
//  Created by jason on 1/23/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "MineCardCollectionViewCell.h"
#import "PetsModel.h"
#import "MomentModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MineCardCollectionViewCell ()


@property(nonatomic,strong)UIImageView *petsIconImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)NSMutableArray *imageViewArray;

@end

@implementation MineCardCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3.0f;
        self.layer.shadowColor   = [UIColor blackColor].CGColor;
        self.layer.shadowOffset  = CGSizeMake(0.0, 0.0);
        self.layer.shadowOpacity = 0.1;
        self.layer.cornerRadius = 3;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.petsIconImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.dateLabel];
    
    NSMutableArray *imageViewArray = [NSMutableArray array];
    CGFloat offsetX = 6.0f;
    for (int i = 0; i < 3; i++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(offsetX, self.dateLabel.bottom + 4.0f, 50.0f, 60.0f)];
        [image sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"MinePeerMoment"]];
        image.clipsToBounds = YES;
        image.layer.cornerRadius = 3.0f;
        
        offsetX = offsetX + image.width + 5.0f;
        [self.contentView addSubview:image];
        [imageViewArray addObject:image];
    }
    self.imageViewArray = imageViewArray;
    
}

- (void)configureWithData:(PetsModel *)petsModel {
    
    [self.petsIconImageView sd_setImageWithURL:[NSURL URLWithString:petsModel.petsAvatar]];
    self.nameLabel.text = petsModel.petsName;
    
    NSRange range = [petsModel.createdTime rangeOfString:@" "];
    NSString *dateString = [petsModel.createdTime stringByReplacingCharactersInRange:NSMakeRange(range.location, petsModel.createdTime.length - range.location ) withString:@""];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"记录于：%@",dateString]];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:[attributeString.string rangeOfString:dateString]];
    self.dateLabel.attributedText = attributeString;
    
    if (petsModel.momentsArray && [petsModel.momentsArray count] > 0) {
        
        for (int i = 0; i < petsModel.momentsArray.count; i++) {
            
            MomentModel *momentsModel = petsModel.momentsArray[i];
            UIImageView *imageView = self.imageViewArray[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:momentsModel.momentTargetUrl] placeholderImage:[UIImage imageNamed:@"MinePeerMoment"]];
            
        }
        
    }
    
}


- (void)layoutSubviews {
    self.petsIconImageView.centerX = self.width / 2.0f;
    self.nameLabel.width = self.width;
    self.dateLabel.width = self.width;
}


- (void)prepareForReuse {
    
    for (UIImageView *imageView in self.imageViewArray) {
        imageView.image = [UIImage imageNamed:@"MinePeerMoment"];
    }
    
}

- (UIImageView *)petsIconImageView {
    if (!_petsIconImageView) {
        _petsIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15.0f, 50.0f, 50.0f)];
        _petsIconImageView.clipsToBounds = YES;
        _petsIconImageView.layer.cornerRadius = _petsIconImageView.width / 2.0f;
    }
    return _petsIconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.petsIconImageView.bottom + 5.0f, 0, 20.0f)];
        _nameLabel.font = [UIFont systemFontOfSize:15.0f];
        _nameLabel.textColor = [UIColor colorWithHex:0x4c4c4c];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom + 10.0f, 0, 14.0f)];
        _dateLabel.font = [UIFont systemFontOfSize:11.0f];
        _dateLabel.textColor = [UIColor colorWithHex:0x999999];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}

@end





