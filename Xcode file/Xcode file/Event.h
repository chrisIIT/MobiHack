//
//  Event.h
//  Xcode file
//
//  Created by Davvid Caballero on 11/14/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friends.h"
#import "User.h"

@interface Event : NSObject
@property NSString *nameOfEvent;
@property NSInteger *timeofEvent;
@property NSDate *dateOfEvent;
@property NSString *descriptionOfEvent;
@property NSMutableArray *friendsInvited;
@property NSMutableArray *friendsGoing;
@property NSMutableArray *friendsNotGoing;
@property NSMutableArray *friendsMightGo;
@property User *creatorOfEvent;

@end
