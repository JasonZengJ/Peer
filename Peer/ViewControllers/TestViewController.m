//
//  TestViewController.m
//  Peer
//
//  Created by jason on 9/19/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "TestViewController.h"
#import "LoginService.h"
#import "UserModel.h"
#import "UIView+Layout.h"
#import "AppService.h"
#import "OSSFileManager.h"
#import <ALBB_OSS_IOS_SDK/OSSTool.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface TestViewController ()


@property(nonatomic)LoginService *loginService;

@end

@implementation TestViewController


- (LoginService *)loginService {
    if (!_loginService) {
        _loginService = [[LoginService alloc] init];
    }
    return _loginService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
  
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Address_CN" withExtension:@"plist"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:url];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths[0] stringByAppendingPathComponent:@"address_CN.plist"];
    
    
    NSLog(@"path : %@",path);
    
    NSMutableDictionary *muteDic = [NSMutableDictionary dictionary];
    
    for (NSString *province in dic) {
        NSArray *cityArray = [dic objectForKey:province];
        NSMutableArray *cityMuteArray = [NSMutableArray array];
        for (NSDictionary *cityDic in cityArray) {
            
            NSMutableDictionary *cityMuteDic = [NSMutableDictionary dictionary];
            for (NSString *city in cityDic) {
                NSArray *areaArray = [cityDic objectForKey:city];
                NSMutableArray *areaMuteArray = [NSMutableArray array];
                for (NSString *area in areaArray) {
                    NSString *muteArea = area;
                    if (area.length == 3) {
                        muteArea = [[area stringByReplacingOccurrencesOfString:@"区" withString:@""] stringByReplacingOccurrencesOfString:@"县" withString:@""];
                    }
                    [areaMuteArray addObject:[self translatePinYinWithText:muteArea]];
                }
                
                NSString *muteCity = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
                [cityMuteDic setObject:[areaMuteArray copy] forKey:[self translatePinYinWithText:muteCity]];
            }
            [cityMuteArray addObject:[cityMuteDic copy]];
            
        }
        [muteDic setObject:[cityMuteArray copy] forKey: [self translatePinYinWithText:province]];
    }
    
   BOOL isWrite =  [muteDic writeToFile:path atomically:YES];
    
    NSLog(@"%@",isWrite ? @"YES":@"NO");
    
}

- (NSString *)translatePinYinWithText:(NSString *)text {
    
//    NSMutableString *ms = [[NSMutableString alloc] initWithString:text];
//    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
////        return ms;
//    }
//    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
//        return ms;
//    }
    return text;
    
}


- (void)testGetApp {
    
}

- (void)addLabelToView:(UIView *)view text:(NSString *)text {
    UILabel *label  = [[UILabel alloc] initWithFrame:view.bounds];
    label.text      = text;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
}

- (void)testUploadFileToOSS {
    
    NSURL *imgUrl = [[NSBundle mainBundle] URLForResource:@"background" withExtension:@"png"];
    NSData *data  = [NSData dataWithContentsOfURL:imgUrl];
    
    OSSFileManager *fileManager = [[OSSFileManager alloc] init];
    [fileManager uploadImageData:data  callback:^(BOOL isSuccess, NSError *error,NSString *fileUrl) {
        NSLog(@"file:%@ %@",fileUrl,isSuccess ? @"YES" : @"NO");
    } progressCallback:^(float progress) {
        DLog(@"uploaded : %f",progress);
    }];
    
    
    
}

- (void)testAutoresize {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    leftView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:leftView];
    [self addLabelToView:leftView text:@"LeftView"];
    
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(leftView.left, leftView.bottom + 20, 100, 100)];
    bottomView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomView];
    [self addLabelToView:bottomView text:@"BottomView"];
    
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(leftView.right + 20, leftView.top, 100, 100)];
    rightView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    [self addLabelToView:rightView text:@"RightView"];
}

- (void)testGetVerificationCode {
    [self.loginService getVerificationCodeWithPhone:@"18501638736" result:^(NSError *error) {
        
    }];
}

- (void)testConfirmVerificationCode {
    [self.loginService confirmVerificationCode:@"3299" result:^(BOOL isSuccess) {
        
    }];
}


- (void)testUserRegister {
    
    UserModel *userModel = [[UserModel alloc] init];
    userModel.phone    = @"18511111112";
    userModel.password = @"123456";
    userModel.nickname = @"jason";
    userModel.sex      = @1;
    userModel.city     = @"深圳";
    userModel.avatar   = @"http://img3.imgtn.bdimg.com/it/u=2117727038,2641018931&fm=21&gp=0.jpg";
    
    
}

- (void)testUserLogin {
    
    UserModel *userModel = [[UserModel alloc] init];
    userModel.phone = @"18512341238";
    userModel.password = @"123456";
    [self.loginService loginWithUserModel:userModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
