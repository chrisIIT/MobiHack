//
//  User.h
//  Xcode file
//
//  Created by Davvid Caballero on 11/13/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Event.h"

@interface User : NSObject
@property NSString *username;
//only hold ids of events/friends
@property NSMutableArray *eventsCreated;
@property NSMutableArray *eventsInvited;
@property NSMutableArray *friendsArray;
@property NSString *password;
@property NSString *ID;
@property NSString *nickname;

//-(Event *)createEvent:(NSString *)eventName des:(NSString *)description eventDate:(NSDate *)date eventTime:(NSInteger *)time PossibleAttendee:(NSMutableArray *)myFriends creator:(User *)event_Creater;
@end
