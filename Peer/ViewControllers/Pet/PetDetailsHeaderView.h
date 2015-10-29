//
//  PetDetailsHeaderView.h
//  Peer
//
//  Created by jason on 10/29/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PetsModel;

@protocol PetDetailsHeaderViewDelegate <NSObject>

- (void)followPet;

@end

@interface PetDetailsHeaderView : UIView

@property(nonatomic,weak) id<PetDetailsHeaderViewDelegate> delegate;

- (void)configureWithPetsModel:(PetsModel *)petsModel;

@end
