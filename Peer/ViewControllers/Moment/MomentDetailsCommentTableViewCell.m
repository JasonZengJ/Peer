//
//  MomentDetailsCommentTableViewCell.m
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentDetailsCommentTableViewCell.h"
#import "CommentModel.h"
#import "NSString+Size.h"
#import "LoginService.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MomentDetailsCommentTableViewCell ()

@property(nonatomic) UIImageView *userAvatarImageView;
@property(nonatomic) UILabel     *userNameLabel;
@property(nonatomic) UILabel     *timeLabel;
@property(nonatomic) UILabel     *contentLabel;
@property(nonatomic) UIView      *commentView;

@end

@implementation MomentDetailsCommentTableViewCell


- (UIImageView *)userAvatarImageView {
    if (!_userAvatarImageView) {
        _userAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, ConvertiPhone5Or6pSize(30.0f), ConvertiPhone5Or6pSize(30.0))];
        _userAvatarImageView.clipsToBounds = YES;
        _userAvatarImageView.layer.cornerRadius = _userAvatarImageView.height / 2;
    }
    return _userAvatarImageView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userAvatarImageView.left, self.userAvatarImageView.bottom + 6, self.userAvatarImageView.width + 2, 15)];
        _timeLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(12.0f)];
        _timeLabel.textColor = [UIColor colorWithHex:0xaaaaaa alpha:1.0];
    }
    return _timeLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userAvatarImageView.right + 10, - 3, ConvertiPhone5Or6pSize(200.0f), ConvertiPhone5Or6pSize(18.0f))];
        _userNameLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(12.0f)];
        _userNameLabel.textColor = [UIColor colorWithHex:0x808080 alpha:1.0];
    }
    return _userNameLabel;
}

- (UIView *)commentView {
    if (!_commentView) {
        _commentView = [[UIView alloc] initWithFrame:CGRectMake(self.userNameLabel.left, self.userNameLabel.bottom, 0, 0)];
        _commentView.backgroundColor = [UIColor whiteColor];
        _commentView.layer.cornerRadius = 3;
        _commentView.layer.borderColor  = [UIColor colorWithHex:0xE4E4E4 alpha:1.0f].CGColor;
        _commentView.layer.borderWidth  = 0.5f;
    }
    return _commentView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        _contentLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(14.0f)];
        _contentLabel.textColor = [UIColor colorWithHex:0x808080 alpha:1.0];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.userAvatarImageView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.commentView];
    [self.commentView addSubview:self.contentLabel];
    
}

- (CGFloat)configureWithCommentModel:(CommentModel *)commentModel {
 
    [self.userAvatarImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.user.avatar]];
    self.timeLabel.text     = @"12:33";
    
    self.userNameLabel.text = commentModel.user.nickname;
    self.userNameLabel.width = [self.userNameLabel.text widthWithFont:self.userNameLabel.font];
    
    if ([commentModel.parentId integerValue] != 0) {
        
        NSString *reply = [NSString stringWithFormat:@"回复%@：",@"jason"];
        NSString *text  = [NSString stringWithFormat:@"%@%@",reply,commentModel.content];
        NSMutableAttributedString *atrributedText = [[NSMutableAttributedString alloc] initWithString:text];
        
        [atrributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor colorWithHex:0x333333 alpha:1.0]
                               range:NSMakeRange(0, reply.length)];
        
        self.contentLabel.attributedText = atrributedText;
        self.contentLabel.size = [self.contentLabel.text sizeWithFont:self.contentLabel.font constraintsSize:CGSizeMake(ConvertiPhone5Or6pSize(325.0f), MAXFLOAT)];
        
    } else {
        self.contentLabel.text = commentModel.content;
        self.contentLabel.size = [self.contentLabel.text sizeWithFont:self.contentLabel.font constraintsSize:CGSizeMake(ConvertiPhone5Or6pSize(325.0f), MAXFLOAT)];
    }
    
    self.commentView.size  = CGSizeMake(self.contentLabel.width + 20.0, self.contentLabel.height + 20.0f);
    if ([LoginService currentUser] && [commentModel.userId isEqualToNumber:[LoginService currentUser].userId]) {
        [self configureUserComments];
    } else {
        [self configurePeopleComments];
    }
    
    return self.commentView.height + 40.0f;
}

- (void)configurePeopleComments {
    
    self.userAvatarImageView.left = 10.0f;
    self.timeLabel.left = 10.0f;
    self.timeLabel.top  =  self.userAvatarImageView.bottom + 6;
    
    self.userNameLabel.left = self.userAvatarImageView.right + 10;
    self.userNameLabel.top  = -3;
    
    self.commentView.left   = self.userNameLabel.left;
    self.commentView.top    = self.userNameLabel.bottom;
}

- (void)configureUserComments {
    
    self.commentView.backgroundColor = [UIColor colorWithHex:0xffb800 alpha:1.0];
    self.contentLabel.textColor      = [UIColor whiteColor];
    
    self.userAvatarImageView.left = ScreenWidth - 10.0f - self.userAvatarImageView.width;
    self.timeLabel.left =  self.userAvatarImageView.left;
    self.timeLabel.top  =  self.userAvatarImageView.bottom + 6;
    
    self.userNameLabel.right = self.userAvatarImageView.left - 10;
    self.userNameLabel.top   = -3;
    
    self.commentView.right  = self.userNameLabel.right;
    self.commentView.top    = self.userNameLabel.bottom;
    
}

- (void)prepareForReuse {
    self.commentView.backgroundColor = [UIColor whiteColor];
    self.contentLabel.text = @"";
    self.contentLabel.attributedText = nil;
    self.contentLabel.textColor      = [UIColor colorWithHex:0x808080 alpha:1.0];
}

@end
