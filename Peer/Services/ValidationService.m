//
//  ValidationService.m
//  Peer
//
//  Created by jason on 9/20/15.
//  Copyright (c) 2015 goodpeer. All rights reserved.
//

#import "ValidationService.h"

@implementation ValidationService


+ (BOOL)checkPhoneNumber:(NSString *)phoneNumber {
    
    NSString *rule = @"^1(3|5|7|8|4)\\d{9}";
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    if (isMatch) {
        return false;
    }
    
    if (phoneNumber.length != 11) {
        return false;
    }
    
    return YES;
}

@end
