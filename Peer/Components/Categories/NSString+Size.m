//
//  NSString+Size.m
//  Peer
//
//  Created by jason on 15/10/18.
//  Copyright © 2015年 peers. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)sizeWithFont:(UIFont *)font constraintsSize:(CGSize)size {
    
   return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width {
    
    return [self sizeWithFont:font constraintsSize:CGSizeMake(width, MAXFLOAT)].height;
}

- (CGFloat)widthWithFont:(UIFont *)font {
    
    return [self sizeWithFont:font constraintsSize:CGSizeMake(ScreenWidth, ScreenHeight)].width;
}

@end
