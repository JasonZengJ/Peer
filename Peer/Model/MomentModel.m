//
//  MomentModel.m
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "MomentModel.h"

@implementation MomentModel

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    
    self = [super init];
    if (self) {
        
        self.momentId = [dict objectForKey:@"id"];
        self.petsId   = [dict objectForKey:@"pets_id"];
        self.userId   = [dict objectForKey:@"user_id"];
        self.momentTitle       = [dict objectForKey:@"moment_title"] ? [dict objectForKey:@"moment_title"] : nil;
        self.momentDescription = [dict objectForKey:@"moment_description"] ? [dict objectForKey:@"moment_description"] : nil;
        self.momentType        = [dict objectForKey:@"moment_type"];
        self.momentTargetUrl   = [dict objectForKey:@"moment_target_url"];
        self.viewAmount        = [dict objectForKey:@"view_amount"];
        self.commentsAmount    = [dict objectForKey:@"comments_amount"];
        self.likeAmount        = [dict objectForKey:@"likeAmount"];
        self.createdAt         = [dict objectForKey:@"created_at"];
        
        if ([self.momentType integerValue] == MomentTypeVideo) {
            self.momentThumbnailUrl = [dict objectForKey:@"moment_thumbnail_url"];
        }
        
    }
    
    return self;
    
}

@end
