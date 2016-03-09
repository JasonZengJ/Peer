//
//  PeerInfoTableView.m
//  Peer
//
//  Created by jason on 3/3/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "PeerInfoTableView.h"
#import "PeerInfoTableSectionView.h"
#import "PeerInfoTableViewCell.h"

@interface PeerInfoTableView ()

@property(nonatomic,strong)NSArray *viewsArray;

@end

@implementation PeerInfoTableView

- (void)reloadDataWithCompletionBlock:(void(^)())completionBlock {
    
    if (!self.tableViewDelegate) {
        return;
    }
    
    [self prepareForCreateViews];
    [self createViews];
    
    if (completionBlock) {
        completionBlock();
    }
    
}

- (void)prepareForCreateViews {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.viewsArray = [NSArray array];
    
}

- (void)createViews {
    
    CGFloat sectionViewTop = 0.0f;
    if (self.headerView) {
        [self addSubview:self.headerView];
        sectionViewTop = self.headerView.bottom;
    }
    
    NSInteger numberOfSection = 1;
    if ([self.tableViewDelegate respondsToSelector:@selector(numberOfSection)]) {
        numberOfSection = [self.tableViewDelegate numberOfSection];
    }
    
    for (int sectionIndex = 0; sectionIndex < numberOfSection; sectionIndex++) {
        
        NSInteger numberOfRows = [self.tableViewDelegate respondsToSelector:@selector(numberOfRowsInSection:)] ? [self.tableViewDelegate numberOfRowsInSection:sectionIndex] : 1;
        CGFloat sectionViewWidth = self.sectionWidth ? self.sectionWidth : self.width - 20.0;
        
        PeerInfoTableSectionView *sectionView = [[PeerInfoTableSectionView alloc] initWithFrame:CGRectMake((self.width - sectionViewWidth) / 2.0f, sectionViewTop, sectionViewWidth, 0.0f)];
        
        CGFloat sectionViewHeight = 0.0;
        CGFloat cellViewTop = 0.0f;
        for (int rowIndex = 0; rowIndex < numberOfRows; rowIndex++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
            CGFloat rowHeight = [self.tableViewDelegate respondsToSelector:@selector(heightForRowAtIndexPath:)] ? [self.tableViewDelegate heightForRowAtIndexPath:indexPath] : 45.0f;
            PeerInfoTableViewCell *cell = [self.tableViewDelegate tableView:self cellForRowAtIndexPath:indexPath];
            if (!cell) {
                @throw [NSException exceptionWithName:@"TableViewCellEmptyException" reason:@"delegate method can not return a nil cell" userInfo:nil];
            }
            cell.frame     = CGRectMake(0, cellViewTop, sectionView.width, rowHeight);
            cell.indexPath = indexPath;
            [cell addTapGestureWithTarget:self action:@selector(tapCell:)];
            [sectionView addSubview:cell];
            cellViewTop += rowHeight;
            sectionViewHeight += rowHeight;
            
        }
        sectionView.height = sectionViewHeight;
        sectionViewTop += (sectionViewHeight + (self.sectionGap ? self.sectionGap : 15.0f));
        
        [self addSubview:sectionView];
        
    }
    
    if (self.footerView) {
        [self addSubview:self.footerView];
    }
    
}

- (void)tapCell:(UIGestureRecognizer *)gesture {
    
    PeerInfoTableViewCell *cell = (PeerInfoTableViewCell *)[gesture view];
    if ([self.tableViewDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.tableViewDelegate tableView:self didSelectRowAtIndexPath:cell.indexPath];
    }
    
}


@end





