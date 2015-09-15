//
//  UIImage+Color.m
//  Peer
//
//  Created by jason on 7/2/14.
//  Copyright (c) 2015 Peer. All rights reserved.
//

#import "UIImage+Color.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>


@implementation UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage *)captureView:(UIView *)view{
    
    UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextFillRect(ctx, [UIScreen mainScreen].bounds);
    [view.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)blurImageWithRadius:(CGFloat)blurRadius{
    if ((blurRadius < 0.0f) || (blurRadius > 1.0f)) {
        blurRadius = 0.5f;
    }
    int boxSize = (int)(blurRadius * 100);
    boxSize    -= (boxSize % 2) + 1;
    
    CGImageRef rawImage = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error  error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(rawImage);
    CFDataRef inBitmapData       = CGDataProviderCopyData(inProvider);
    
    inBuffer.width     = CGImageGetWidth(rawImage);
    inBuffer.height    = CGImageGetHeight(rawImage);
    inBuffer.rowBytes  = CGImageGetBytesPerRow(rawImage);
    inBuffer.data      = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer        = malloc(CGImageGetBytesPerRow(rawImage) * CGImageGetHeight(rawImage));
    
    outBuffer.data     = pixelBuffer;
    outBuffer.width    = CGImageGetWidth(rawImage);
    outBuffer.height   = CGImageGetHeight(rawImage);
    outBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error for convolution %ld",error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx           = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, CGImageGetBitmapInfo(self.CGImage));
    CGImageRef imageRef        = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage       = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}
@end
