//
//  MomentDetailsViewController.h
//  Peer
//
//  Created by jason on 10/22/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MomentModel;

@interface MomentDetailsViewController : UIViewController


- (void)loadDataWithMomentModel:(MomentModel *)model;

@end
