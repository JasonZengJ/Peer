//
//  UIView+RoundBorderShadow.m
//  Peer
//
//  Created by jason on 3/10/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "UIView+RoundBorderShadow.h"

@implementation UIView (RoundBorderShadow)


- (void)configRoundBorderShadow {
    
    self.layer.cornerRadius  = 3;
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowOffset  = CGSizeMake(0, 0);
    self.layer.shadowColor   = [UIColor blackColor].CGColor;
    self.backgroundColor     = [UIColor whiteColor];
	
}
@end
