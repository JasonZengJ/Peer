//
//  PeerInfoTableViewCell.h
//  Peer
//
//  Created by jason on 3/6/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeerInfoTableViewCell : UIView

@property(nonatomic,strong) NSIndexPath *indexPath;
@property(nonatomic,strong) UILabel *leftTitleLabel;
@property(nonatomic,strong) UILabel *rightTitleLabel;
@property(nonatomic,strong) UIView  *rightView;
@property(nonatomic,strong) UIView  *accessoryView;

@property(nonatomic,assign) BOOL needAccessoryView;
@property(nonatomic,assign) BOOL needBottomLine;
@property(nonatomic,assign) CGFloat bottomLineOffset;
@property(nonatomic,assign) CGFloat bottomLineLast;

@end
