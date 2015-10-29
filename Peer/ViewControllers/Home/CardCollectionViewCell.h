//
//  CardCollectionViewCell.h
//  Peer
//
//  Created by jason on 10/16/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MomentModel;

@protocol CardCollectionViewCellDelegate <NSObject>

- (void)tapPetAvatarWithIndex:(NSInteger)index;

@end

@interface CardCollectionViewCell : UICollectionViewCell

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,weak) id<CardCollectionViewCellDelegate> delegate;

- (void)configureWithMoments:(MomentModel *)momentModel;

@end
