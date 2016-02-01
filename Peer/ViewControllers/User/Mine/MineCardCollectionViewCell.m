//
//  MineCardCollectionViewCell.m
//  Peer
//
//  Created by jason on 1/23/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "MineCardCollectionViewCell.h"

@implementation MineCardCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3.0f;
        self.layer.shadowColor   = [UIColor blackColor].CGColor;
        self.layer.shadowOffset  = CGSizeMake(0.0, 0.0);
        self.layer.shadowOpacity = 0.1;
        self.layer.cornerRadius = 3;
    }
    return self;
}

- (void)initSubviews {
    
}

- (void)configureWithData:(NSDictionary *)data {
	
}

@end
