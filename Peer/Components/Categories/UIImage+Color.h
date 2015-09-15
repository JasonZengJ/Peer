//
//  UIImage+Color.h
//  Peer
//
//  Created by jason on 7/2/14.
//  Copyright (c) 2015 Peer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)


+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)blurImageWithRadius:(CGFloat)blurRadius;

+ (UIImage *)captureView:(UIView *)view;
@end
