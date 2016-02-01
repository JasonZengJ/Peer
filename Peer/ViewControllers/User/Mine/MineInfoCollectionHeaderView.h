//
//  MineInfoCollectionHeaderView.h
//  Peer
//
//  Created by jason on 1/23/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserModel;

@interface MineInfoCollectionHeaderView : UICollectionReusableView
- (void)configureWithUserModel:(UserModel *)userModel;

@end
