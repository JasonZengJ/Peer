//
//  ApplicationDirectoryService.h
//  Peer
//
//  Created by jason on 10/3/15.
//  Copyright © 2015 peers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationDirectoryService : NSObject

+ (NSString *)applicationImageDirectory;

+ (NSString *)applicationDocumentsDirectory;

@end
