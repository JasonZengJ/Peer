//
//  PetDetailsHorizonCardFlowLayout.m
//  Peer
//
//  Created by jason on 10/29/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "PetDetailsHorizonCardFlowLayout.h"

@implementation PetDetailsHorizonCardFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize  = CGSizeMake(ConvertiPhone5Or6pSize(185.0), self.collectionView.height - 30.0f);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(30.0f, 25.0f,0.0,25.0);
    self.minimumLineSpacing = 25.0f;
}

@end
