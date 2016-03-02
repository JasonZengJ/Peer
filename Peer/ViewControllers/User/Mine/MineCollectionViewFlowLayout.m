//
//  MineCollectionViewFlowLayout.m
//  Peer
//
//  Created by jason on 1/23/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "MineCollectionViewFlowLayout.h"

@implementation MineCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize  = CGSizeMake((ScreenWidth - 30.0f) / 2, (ScreenWidth - 30.0f) / 2 + 10.0f);
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(10.0, 10, 0, 10);
//    self.minimumLineSpacing = ConvertiPhone5Or6pSize(25);
}


@end
