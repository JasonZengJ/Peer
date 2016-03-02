//
//  MineAddPeerCollectionViewCell.m
//  Peer
//
//  Created by jason on 2/28/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "MineAddPeerCollectionViewCell.h"

@interface MineAddPeerCollectionViewCell ()

@property(nonatomic,strong)UIImageView *addPeerIconImageView;
@property(nonatomic,strong)UILabel *addPeerTitleLabel;

@end

@implementation MineAddPeerCollectionViewCell


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

- (void)initUI {
    
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.addPeerIconImageView];
    [self.contentView addSubview:self.addPeerTitleLabel];
    
}

- (UIImageView *)addPeerIconImageView {
    if (!_addPeerIconImageView) {
        _addPeerIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50.0f, 50.0f, 50.0f)];
        _addPeerIconImageView.image = [UIImage imageNamed:@"MineAddPeer"];
    }
    return _addPeerIconImageView;
}

- (UILabel *)addPeerTitleLabel {
    if (!_addPeerTitleLabel) {
        _addPeerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.addPeerIconImageView.bottom + 25.0f, 0, 17.0f)];
        _addPeerTitleLabel.text = @"添加Peer";
        _addPeerTitleLabel.font = [UIFont systemFontOfSize:14.0f];
        _addPeerTitleLabel.textColor = [UIColor colorWithHex:0x999999];
        _addPeerTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addPeerTitleLabel;
}

- (void)layoutSubviews {
    _addPeerIconImageView.centerX = self.width / 2.0f;
    _addPeerTitleLabel.width = self.width;
    
}



@end






