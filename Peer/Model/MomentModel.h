//
//  MomentModel.h
//  Peer
//
//  Created by jason on 10/11/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "BaseModel.h"
#import "PetsModel.h"

typedef NS_ENUM(NSInteger,MomentType) {
    MomentTypePhoto = 1,
    MomentTypeVideo = 2,
    
};

@interface MomentModel : BaseModel

@property(nonatomic) NSNumber  *momentId;
@property(nonatomic) NSNumber  *petsId;
@property(nonatomic) NSNumber  *userId;
@property(nonatomic) NSString<Optional> *momentTitle;
@property(nonatomic) NSString  *momentDescription;
@property(nonatomic) NSNumber  *momentType;
@property(nonatomic) NSString  *momentTargetUrl;
@property(nonatomic) NSString  *momentThumbnailUrl;
@property(nonatomic) NSNumber  *viewAmount;
@property(nonatomic) NSNumber  *commentsAmount;
@property(nonatomic) NSNumber  *likeAmount;
@property(nonatomic) NSString  *createdAt;
@property(nonatomic) NSString  *weather;
@property(nonatomic) NSString  *city;
@property(nonatomic) NSString  *area;
@property(nonatomic) PetsModel<Optional> *pet;

@end
