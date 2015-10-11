//
//  ApplicationDirectoryService.m
//  Peer
//
//  Created by jason on 10/3/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import "ApplicationDirectoryService.h"


static NSString *const ImageDirectory = @"PeerImg";

@implementation ApplicationDirectoryService

+ (void)initApplicationDirectoryService {
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    bool isDir = YES;
    
    if (![fileManager fileExistsAtPath:[ApplicationDirectoryService applicationImageDirectory] isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:[ApplicationDirectoryService applicationImageDirectory] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
}

+ (NSString *)applicationImageDirectory {
    
    return [NSString stringWithFormat:@"%@/%@",[ApplicationDirectoryService applicationDocumentsDirectory],ImageDirectory];

}

+ (NSString *)applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths[0];
    
}

@end
