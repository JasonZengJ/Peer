//
//  HorizontalCardTableView.m
//  Peer
//
//  Created by jason on 10/15/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "HorizontalCardTableView.h"
#import "HCTableViewCell.h"


#define CardGap 30;
#define LeftGap 15;

@implementation HCIndexPath

+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    
    HCIndexPath *indexPath = [[HCIndexPath alloc] init];
    indexPath.row     = row;
    indexPath.section = section;
    return indexPath;
    
}

- (void)setRow:(NSInteger)row {
    self.row = row;
}

- (void)setSection:(NSInteger)section {
    self.section = section;
}

@end



@interface HorizontalCardTableView ()




@end

@implementation HorizontalCardTableView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.alwaysBounceHorizontal = YES;
    }
    return self;
    
}


- (void)layoutSubviews {
    
    NSLog(@"layout subviews");
    
}

- (void)reloadCardViews {
    
    if (!self.dataArray || ![self.dataArray count]) {
        return;
    }
    
    [self createHCTableViewCells];
    
    
}

- (void)createHCTableViewCells {
    
}





@end
