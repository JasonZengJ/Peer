//
//  HorizonCardFlowLayout.m
//  Peer
//
//  Created by jason on 10/16/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "HorizonCardFlowLayout.h"
#import "LayoutUtil.h"
#import "UIView+Layout.h"



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
    self.sectionInset = UIEdgeInsetsMake(0, 40, 0, 40);
    self.minimumLineSpacing = 25;
    
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
   CGFloat offsetAdjustment = MAXFLOAT;
   CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
   //  当前显示的区域
   CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.width, self.collectionView.height);
    
    //  取当前显示的item
   NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    //  对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
    
}

@end

















