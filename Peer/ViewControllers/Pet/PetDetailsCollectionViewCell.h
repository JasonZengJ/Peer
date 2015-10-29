//
//  PetDetailsCollectionViewCell.h
//  Peer
//
//  Created by jason on 10/29/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MomentModel;

@interface PetDetailsCollectionViewCell : UICollectionViewCell

- (void)configureWithMoments:(MomentModel *)momentModel;

@end
