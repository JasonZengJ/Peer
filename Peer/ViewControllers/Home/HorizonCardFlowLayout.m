//
//  HorizonCardFlowLayout.m
//  Peer
//
//  Created by jason on 10/16/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "HorizonCardFlowLayout.h"
#import "LayoutUtil.h"



#define CardWidth  ConvertToiPhone6XYZ(250)
#define CardHeight ConvertToiPhone6XYZ(430)


@implementation HorizonCardFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    
    self.itemSize = CGSizeMake(CardWidth, CardHeight);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, 40, 0, 00);
    self.minimumLineSpacing = 25;
    
    
}

@end
