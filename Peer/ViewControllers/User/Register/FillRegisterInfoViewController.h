//
//  FillRegisterInfoViewController.h
//  Peer
//
//  Created by jason on 11/4/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "RootNavViewController.h"

typedef NS_ENUM(NSInteger,RegisterInfoFillType) {
    RegisterInfoFillTypeNickname = 1,
    RegisterInfoFillTypeUserDescription = 2,
    
};

@interface FillRegisterInfoViewController : RootNavViewController

@property(nonatomic,assign) RegisterInfoFillType registerInfoFillType;

@end
