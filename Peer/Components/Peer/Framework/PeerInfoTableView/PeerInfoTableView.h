//
//  PeerInfoTableView.h
//  Peer
//
//  Created by jason on 3/3/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeerInfoTableViewCell.h"

@class PeerInfoTableView;

@protocol PeerInfoTableViewDelegate <NSObject>


- (nonnull PeerInfoTableViewCell *)tableView:(nonnull PeerInfoTableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@optional
- (CGFloat)sectionSeperatorLineHeightForSection:(NSInteger)section;

- (CGFloat)heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (NSInteger)numberOfSection;

- (void)tableView:(nonnull PeerInfoTableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath;

@end

@interface PeerInfoTableView : UIScrollView

@property(nullable,nonatomic,weak)id<PeerInfoTableViewDelegate> tableViewDelegate;
@property(nullable,nonatomic,strong)UIView *headerView;
@property(nullable,nonatomic,strong)UIView *footerView;
@property(nonatomic,assign)CGFloat sectionGap;
@property(nonatomic,assign)CGFloat sectionWidth;

- (void)reloadDataWithCompletionBlock:( void(^ _Nullable )())completionBlock;

@end




