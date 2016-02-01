//
//  PetsModel.h
//  Peer
//
//  Created by jason on 9/22/15.
//  Copyright (c) 2015 peers. All rights reserved.
//

#import "BaseModel.h"

@interface PetsModel : BaseModel

@property(nonatomic) NSNumber *petsId;
@property(nonatomic) NSString *petsName;
@property(nonatomic) NSNumber *petsSex;
@property(nonatomic) NSNumber *petsYear;
@property(nonatomic) NSNumber *petsMonth;
@property(nonatomic) NSString *petsAvatar;
@property(nonatomic) NSNumber *petsBreedId;
@property(nonatomic) NSNumber *petsSpeciesId;
@property(nonatomic) NSNumber *userId;

@end
