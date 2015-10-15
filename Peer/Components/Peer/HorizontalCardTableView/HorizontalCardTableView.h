//
//  HorizontalCardTableView.h
//  Peer
//
//  Created by jason on 10/15/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalCardTableView;
@class HCIndexPath;

@protocol HorizontalCardTableViewDataSource <NSObject>

@required

- (NSInteger)cardTableView:(HorizontalCardTableView *)cardTableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)cardTableView:(HorizontalCardTableView *)cardTableVie cellForRowAtIndexPath:(HCIndexPath *)indexPath;


@end

@protocol HorizontalCardTableViewDelegate <NSObject>


@end

@interface HCIndexPath : NSObject

+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;

@property (nonatomic, readonly) NSInteger section;
@property (nonatomic, readonly) NSInteger row;

@end

@interface HorizontalCardTableView : UIScrollView


@property(nonatomic) NSArray *dataArray;

@property(nonatomic,weak) id<HorizontalCardTableViewDataSource> cardTableViewDataSource;
@property(nonatomic,weak) id<HorizontalCardTableViewDelegate>   cardTableViewDelegate;

- (void)reloadCardViews;

@end
