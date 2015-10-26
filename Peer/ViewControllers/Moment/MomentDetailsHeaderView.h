//
//  MomentDetailsHeaderView.h
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

@class MomentModel;

@interface MomentDetailsHeaderView : UIView




- (void)configureWithMomentModel:(MomentModel *)momentModel;


- (void)configureLikedUsersAvatarWithArray:(NSArray *)likedUsersAvatarUrlArray;

@end
