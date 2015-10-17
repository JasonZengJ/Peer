//
//  LayoutUtil.m
//  Peer
//
//  Created by jason on 10/16/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "LayoutUtil.h"

@implementation LayoutUtil


+ (CGFloat)iPhone6Scale {
    if(!(IS_IPHONE_6 || IS_IPHONE_6_PLUS))
        return 1.0f;
    
    [[[UIDevice currentDevice] systemVersion] integerValue];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat scale = (CGRectGetWidth(screenBounds)/320.0f);
    return scale;
}

@end

#define ScaleSize       1.134
CG_EXTERN CGFloat ConvertToiPhone6XYZ(CGFloat v) {
    
    if (IS_IPHONE_6_PLUS) {
        return (CGFloat)(v > 0 ? ceil(v * ScaleSize) : floor(v * ScaleSize));
    } else {
        return (CGFloat)(v > 0 ? ceil(v * [LayoutUtil iPhone6Scale]) : floor(v * [LayoutUtil iPhone6Scale]));
    }
    
}