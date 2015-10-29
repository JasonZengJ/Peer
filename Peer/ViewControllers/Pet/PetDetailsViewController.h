//
//  PetDetailsViewController.h
//  Peer
//
//  Created by jason on 10/29/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavViewController.h"

@class PetsModel;


@interface PetDetailsViewController : RootNavViewController

@property(nonatomic,strong)PetsModel *petsModel;


@end
