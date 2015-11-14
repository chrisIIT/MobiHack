//
//  User.m
//  Xcode file
//
//  Created by Davvid Caballero on 11/13/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "User.h"
#import "Friends.h"
#import "Event.h"

@implementation User

@synthesize username,eventsCreated,eventsInvited,password;

-(void)changeUsername:(NSString *)newUsername{
    username = newUsername;
}

-(void)changePassword:(NSString *)newPassword{
    password=newPassword;
}

-(Event *)createEvent:(NSString *)eventName des:(NSString *)description eventDate:(NSDate *)date eventTime:(NSInteger *)time PossibleAttendee:(NSMutableArray *)myFriends creator:(User *)event_Creater{
    Event *myEvent;
    myEvent.nameOfEvent=eventName;
    myEvent.descriptionOfEvent=description;
    myEvent.dateOfEvent=date;
    myEvent.timeofEvent=time;
    myEvent.friendsInvited=myFriends;
    myEvent.creatorOfEvent=event_Creater;
    
    return myEvent;
}
@end
