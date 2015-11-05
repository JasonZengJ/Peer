//
//  MomentDetailsBottomView.m
//  Peer
//
//  Created by jason on 10/27/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentDetailsBottomView.h"

@interface MomentDetailsBottomView ()

@property(nonatomic) UIImageView *emotionImageView;
@property(nonatomic) UITextField *commentTextfield;
@property(nonatomic) UIButton    *commentButton;

@end

@implementation MomentDetailsBottomView

- (UIImageView *)emotionImageView {
    if (!_emotionImageView) {
        _emotionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, ConvertiPhone5Or6pSize(25.0f), ConvertiPhone5Or6pSize(25.0f))];
        _emotionImageView.image  = [UIImage imageNamed:@"MomentDetailsEmotion"];
        _emotionImageView.centerY = self.height / 2;
        
    }
    return _emotionImageView;
}

- (UITextField *)commentTextfield {
    if (!_commentTextfield) {
        
        _commentTextfield = [[UITextField alloc] initWithFrame:CGRectMake(self.emotionImageView.right + 10, 5, ConvertiPhone5Or6pSize(270.0f), ConvertiPhone5Or6pSize(35.0f))];
        _commentTextfield.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)];
        _commentTextfield.backgroundColor = [UIColor whiteColor];
        _commentTextfield.placeholder     = NSLocalizedString(@"MomentDetailsAddComment", nil);
        _commentTextfield.leftViewMode    = UITextFieldViewModeAlways;
        _commentTextfield.leftView        = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 10, 10)];
        _commentTextfield.layer.cornerRadius = 3.0f;
        
    }
    return _commentTextfield;
}

- (UIButton *)commentButton {
    
    if (!_commentButton) {
        
        _commentButton = [[UIButton alloc] initWithFrame:CGRectMake(self.commentTextfield.right, 0, ConvertiPhone5Or6pSize(60.0f), self.height)];
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)];
        [_commentButton setTitle:NSLocalizedString(@"MomentDetailsSend", nil) forState:UIControlStateNormal];
        [_commentButton setTitleColor:[UIColor colorWithHex:0x333333 alpha:1.0] forState:UIControlStateNormal];
        [_commentButton addTarget:self action:@selector(sendCommentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_commentButton setBackgroundColor:[UIColor clearColor]];
        
    }
    
    return _commentButton;
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}


- (void)initSubviews {
    
    self.backgroundColor = [UIColor colorWithHex:0xF5F5F5 alpha:1.0];
    [self addSubview:self.emotionImageView];
    [self addSubview:self.commentTextfield];
    [self addSubview:self.commentButton];
    
}

- (void)sendCommentButtonAction:(id)sender {
    [self.commentTextfield resignFirstResponder];
}

@end
