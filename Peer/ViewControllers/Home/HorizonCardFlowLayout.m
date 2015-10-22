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

#define CardTop  90.0

@implementation HorizonCardFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize  = CGSizeMake(CardWidth, CardHeight);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(80, 40, 88, 40);
    self.minimumLineSpacing = ConvertiPhone5Or6pSize(25);
}

//  初始的layout外观将由该方法返回的UICollctionViewLayoutAttributes来决定
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect  {
    
//    NSLog(@"\n");
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            
//            NSLog(@"center x:---%f   origin:%f",attributes.center.x,attributes.frame.origin.y);
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
//            NSLog(@"distance :---%f",distance);

            CGFloat normalizedDistance = distance / (CardWidth + self.minimumLineSpacing - 1);
//            NSLog(@"normalizedDistance :---%f     ",normalizedDistance);
            if ( ABS(distance) < (CardWidth + self.minimumLineSpacing)) {
                
                CGFloat zoom = CardEdge * (ABS(normalizedDistance) - 1);
                CGRect frame = attributes.frame;
                
                frame.origin.y   = CardTop + zoom;
//                frame.size.width = CardWidth - (ABS(zoom) * normalizedDistance);
                frame.size.height = CardHeight - zoom + 2*((ABS(normalizedDistance) - 1));
                
//                NSLog(@"zoom :----%f  frame--y: %f",zoom,frame.origin.y);
                attributes.frame = frame;
            } else {
                
                CGRect frame = attributes.frame;
                frame.origin.y = CardTop;
//                frame.size.width = CardWidth  - CardEdge - 1 ;
                attributes.frame = frame;
                
            }
            
//            NSLog(@"frame:  %@",NSStringFromCGRect(attributes.frame));
        }
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
   CGFloat offsetAdjustment = MAXFLOAT;
   CGFloat horizontalCenter = proposedContentOffset.x + self.collectionView.width / 2.0;
    
    //  当前显示的区域
    CGRect targetRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    //  取当前显示的item
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    //  对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(horizontalCenter - itemHorizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment + 1, proposedContentOffset.y);
    
}

@end

















