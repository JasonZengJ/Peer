//
//  CardCollectionViewCell.h
//  Peer
//
//  Created by jason on 10/16/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MomentModel;

@interface CardCollectionViewCell : UICollectionViewCell


- (void)configureWithMoments:(MomentModel *)momentModel;

@end
