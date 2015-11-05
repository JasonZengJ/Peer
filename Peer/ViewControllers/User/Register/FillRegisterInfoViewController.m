//
//  FillRegisterInfoViewController.m
//  Peer
//
//  Created by jason on 11/4/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "FillRegisterInfoViewController.h"

@interface FillRegisterInfoViewController ()

@property(nonatomic) UITextField *textField;
@property(nonatomic) UITextView  *textView;

@end

@implementation FillRegisterInfoViewController


- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 64.0f + 10.0f, self.view.width - 20.0f, ConvertiPhone5Or6pSize(45.0f))];
        _textField.textColor           = [UIColor colorWithHex:0x4c4c4c];
        _textField.placeholder = NSLocalizedString(@"RegisterFillInNicknamePlaceHolder", nil);
        [_textField setFont:[UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]];
        
        NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor colorWithHex:0xe5e5e5],NSFontAttributeName: [UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]};
        NSAttributedString * nickName = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"RegisterFillInNicknamePlaceHolder", nil)attributes:attributes];
        _textField.attributedPlaceholder = nickName;
        _textField.leftViewMode  = UITextFieldViewModeAlways;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        _textField.leftView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _textField.height)];
        _textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, _textField.height)];
        [self configureShadowView:_textField];
        
        
        
        
    }
    return _textField;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 64.0f + 10, self.view.width - 20, ConvertiPhone5Or6pSize(150.0f))];
        _textView.textColor = [UIColor colorWithHex:0x4c4c4c];
        _textView.backgroundColor = [UIColor whiteColor];
//        _textView
//        _textView.contentInset    = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        [_textView setFont:[UIFont systemFontOfSize:ConvertiPhone5Or6pSize(16.0f)]];
        
        [self configureShadowView:_textView];
    }
    return _textView;
}

- (void)configureShadowView:(UIView *)view {
    view.backgroundColor     = [UIColor whiteColor];
    view.layer.cornerRadius  = 3;
    view.layer.shadowColor   = [UIColor blackColor].CGColor;
    view.layer.shadowOffset  = CGSizeMake(0.0, 0.0);
    view.layer.shadowOpacity = 0.1;
    view.layer.masksToBounds = NO;
}

- (void)loadView {
    [super loadView];
    
    switch (self.registerInfoFillType) {
        case RegisterInfoFillTypeNickname: {
            [self.view addSubview:self.textField];
        }
            break;
        case RegisterInfoFillTypeUserDescription: {
            [self.view addSubview:self.textView];
        }
            break;
        default:
            break;
    }
}

- (void)backButtonAction:(UIButton *)sender {
    [super backButtonAction:sender];
    
    switch (self.registerInfoFillType) {
        case RegisterInfoFillTypeNickname: {
            if (self.delegate && [self.delegate respondsToSelector:@selector(fillNickname:)]) {
                [self.delegate fillNickname:self.textField.text];
            }
        }
            break;
        case RegisterInfoFillTypeUserDescription: {
            if (self.delegate && [self.delegate respondsToSelector:@selector(fillUserDescription:)]) {
                [self.delegate fillUserDescription:self.textView.text];
            }
        }
            break;
        default:
            break;
    }
}

- (UIBarButtonItem *)rightBarButtonItem {
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.automaticallyAdjustsScrollViewInsets = NO;
}

@end
