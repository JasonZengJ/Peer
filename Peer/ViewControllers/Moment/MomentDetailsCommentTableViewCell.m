//
//  MomentDetailsCommentTableViewCell.m
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentDetailsCommentTableViewCell.h"
#import "CommentModel.h"

@interface MomentDetailsCommentTableViewCell ()

@end

@implementation MomentDetailsCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    
}

- (void)configureWithCommentModel:(CommentModel *)commentModel {
    
}

@end
