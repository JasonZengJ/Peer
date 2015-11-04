//
//  UIAlertView+AlertMessage.m
//  Peer
//
//  Created by jason on 11/4/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "UIAlertView+AlertMessage.h"

@implementation UIAlertView (AlertMessage)


+ (void)alertWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end
