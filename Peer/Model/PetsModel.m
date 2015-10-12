//
//  PetsModel.m
//  Peer
//
//  Created by jason on 9/22/15.
//  Copyright (c) 2015 peers. All rights reserved.
//

#import "PetsModel.h"

@implementation PetsModel

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    
    self = [super init];
    if (self) {
        self.userId   = [dict objectForKey:@"user_id"];
        self.petsId   = [dict objectForKey:@"id"];
        self.petsName = [dict objectForKey:@"pets_name"];
        self.petsSex  = [dict objectForKey:@"pets_sex"];
        self.petsAge  = [dict objectForKey:@"pets_age"];
        self.petsMonth  = [dict objectForKey:@"pets_month"];
        self.petsAvatar = [dict objectForKey:@"pets_avatar"];
        self.petsBreedId = [dict objectForKey:@"pets_breed_id"];
        self.petsSpeciesId = [dict objectForKey:@"pets_species_id"];
        
    }
    return self;
    
}


@end
