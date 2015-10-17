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



#define CardWidth  ConvertToiPhone6XYZ(250.0)
#define CardHeight ConvertToiPhone6XYZ(420.0)
#define CardTopEdge 15
#define CardTop 81.0


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

//  初始的layout外观将由该方法返回的UICollctionViewLayoutAttributes来决定
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSLog(@"\n");
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            
            
            NSLog(@"center x:---%f   origin:%f",attributes.center.x,attributes.frame.origin.y);
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            NSLog(@"distance :---%f",distance);

            CGFloat normalizedDistance = distance * 2 / CardWidth;
            NSLog(@"normalizedDistance :---%f     ",normalizedDistance);
            if (ABS(distance) < CardWidth/2.0f) {
                CGFloat zoom = CardTopEdge*(ABS(normalizedDistance) - 1);
                CGRect frame = attributes.frame;
                frame.origin.y = ConvertToiPhone6XYZ(CardTop) + zoom;
                frame.size.height = CardHeight - zoom + 2*((ABS(normalizedDistance) - 1));
                
                NSLog(@"zoom :----%f  frame--y: %f",zoom,frame.origin.y);
                attributes.frame = frame;
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
//                attributes.zIndex = 1;
                
            } else {
                CGRect frame = attributes.frame;
                frame.origin.y = ConvertToiPhone6XYZ(CardTop);
                attributes.frame = frame;
            }
        }
    }
    return array;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
   CGFloat offsetAdjustment = MAXFLOAT;
   CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
   //  当前显示的区域
   CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
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

















