//
//  MomentDetailsCommentTableViewCell.h
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;

#define CommentTableViewCell @"CommentTableViewCell"

@interface MomentDetailsCommentTableViewCell : UITableViewCell


- (CGFloat)configureWithCommentModel:(CommentModel *)commentModel;

@end
