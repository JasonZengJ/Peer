//
//  UIAlertController+AlertMessage.h
//  Peer
//
//  Created by jason on 3/13/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (AlertMessage)


+ (UIAlertController *)defaultAlertWithSubtitle:(NSString *)subtitle confirmAction:(void (^ )(UIAlertAction *action))confirmAction;

+ (UIAlertController *)defaultAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle confirmAction:(void (^ )(UIAlertAction *action))confirmAction cancelAction:(void (^ )(UIAlertAction *action))cancelAction;
+ (UIAlertController *)defaultAlertWithSubtitle:(NSString *)subtitle cancelAction:(void (^ )(UIAlertAction *action))cancelAction;

@end
