//
//  User.h
//  Xcode file
//
//  Created by Davvid Caballero on 11/13/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property NSString *username;
@property NSMutableArray *eventsCreated;
@property NSMutableArray *eventsInvited;
@property NSString *password;
@property NSInteger *ID;
@end
