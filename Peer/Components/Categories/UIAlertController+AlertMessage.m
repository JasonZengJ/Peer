//
//  UIAlertController+AlertMessage.m
//  Peer
//
//  Created by jason on 3/13/16.
//  Copyright © 2016 peers. All rights reserved.
//

#import "UIAlertController+AlertMessage.h"

@implementation UIAlertController (AlertMessage)

+ (UIAlertController *)defaultAlertWithSubtitle:(NSString *)subtitle confirmAction:(void (^ )(UIAlertAction *action))confirmAction {
    return [[self class] defaultAlertWithTitle:@"温馨提示" subtitle:subtitle confirmAction:confirmAction cancelAction:nil];
}

+ (UIAlertController *)defaultAlertWithSubtitle:(NSString *)subtitle cancelAction:(void (^ )(UIAlertAction *action))cancelAction {
    return [[self class] defaultAlertWithTitle:@"温馨提示" subtitle:subtitle confirmAction:nil cancelAction:cancelAction];
}


+ (UIAlertController *)defaultAlertWithTitle:(NSString *)title subtitle:(NSString *)subtitle confirmAction:(void (^ )(UIAlertAction *action))confirmAction cancelAction:(void (^ )(UIAlertAction *action))cancelHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:subtitle preferredStyle:UIAlertControllerStyleAlert];
    if (confirmAction) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancelHandler];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirmAction];
        [alertController addAction:cancelAction];
        [alertController addAction:alertAction];
    } else {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:cancelHandler];
        [alertController addAction:cancelAction];
    }
    
    return alertController;
}




@end
