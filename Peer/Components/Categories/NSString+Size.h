//
//  NSString+Size.h
//  Peer
//
//  Created by jason on 15/10/18.
//  Copyright © 2015年 peers. All rights reserved.
//


@interface NSString (Size)

- (CGSize)sizeWithFont:(UIFont *)font constraintsSize:(CGSize)size;

- (CGFloat)heightWithFont:(UIFont *)font ;


- (CGFloat)widthWithFont:(UIFont *)font ;

@end
