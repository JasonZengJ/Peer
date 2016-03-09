//
//  PeerInfoTableSectionView.m
//  Peer
//
//  Created by jason on 3/3/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "PeerInfoTableSectionView.h"

@implementation PeerInfoTableSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius  = 3;
        self.layer.shadowOpacity = 0.1;
        self.layer.shadowOffset  = CGSizeMake(0, 0);
        self.layer.shadowColor   = [UIColor blackColor].CGColor;
        self.backgroundColor     = [UIColor whiteColor];
    }
    return self;
}

@end
