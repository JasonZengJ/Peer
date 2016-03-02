//
//  PetsModel.m
//  Peer
//
//  Created by jason on 9/22/15.
//  Copyright (c) 2015 peers. All rights reserved.
//

#import "PetsModel.h"
#import "MomentModel.h"
#import "NSDate+Calendar.h"

@implementation PetsModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.petsMonth = @1;
        self.petsYear  = @([NSDate currentYear] - 1);
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    
    self = [super init];
    if (self) {
        self.userId   = [dict objectForKey:@"user_id"];
        self.petsId   = [dict objectForKey:@"id"];
        self.petsName = [dict objectForKey:@"pets_name"];
        self.petsSex  = [dict objectForKey:@"pets_sex"];
        self.petsYear  = [dict objectForKey:@"pets_year"];
        self.petsMonth  = [dict objectForKey:@"pets_month"];
        self.petsAvatar = [dict objectForKey:@"pets_avatar"];
        self.petsBreedId   = [dict objectForKey:@"pets_breed_id"];
        self.petsSpeciesId = [dict objectForKey:@"pets_species_id"];
        self.createdTime   = [dict objectForKey:@"created_at"];
        
        if (dict[@"moments"] && [dict[@"moments"] count] > 0) {
            
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (NSDictionary *dataDic in dict[@"moments"]) {
                MomentModel *momentsModel = [[MomentModel alloc] initWithDictionary:dataDic error:nil];
                [mutableArray addObject:momentsModel];
            }
            self.momentsArray = mutableArray;
            
        }
        
    }
    return self;
    
}


@end
