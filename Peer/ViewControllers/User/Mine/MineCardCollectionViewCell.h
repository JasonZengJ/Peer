//
//  MineCardCollectionViewCell.h
//  Peer
//
//  Created by jason on 1/23/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PetsModel;


@interface MineCardCollectionViewCell : UICollectionViewCell


- (void)configureWithData:(PetsModel *)petsModel;

@end
