//
//  MomentDetailsHeaderView.h
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

@class MomentModel;

@protocol MomentDetailsHeaderViewDelegate <NSObject>


- (void)tapPetAvatar;
- (void)tapUserAvatar;
- (void)tapLikeMoment;

@end

@interface MomentDetailsHeaderView : UIView


@property(nonatomic,weak) id<MomentDetailsHeaderViewDelegate> delegate;


- (void)configureWithMomentModel:(MomentModel *)momentModel;


- (void)configureLikedUsersAvatarWithArray:(NSArray *)likedUsersAvatarUrlArray;

@end
