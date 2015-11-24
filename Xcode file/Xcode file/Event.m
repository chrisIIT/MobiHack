//
//  Event.m
//  Xcode file
//
//  Created by Davvid Caballero on 11/14/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "Event.h"

@implementation Event


//when passing the array to remove from we pass integers to do a switch case in order to know where to look
//  0 = remove from invited
//  1 = remove/add to going
//  2 = remove/add to not going
//  3 = remove/add to maybe going
-(void)removeFriend:(Event *)eventToRemoveFrom friend:(Friends *)friendToRemove arrayToRemoveFrom:(NSNumber *)removeFromHere{
    int i;
    int toSwitch = [removeFromHere intValue];

    switch (toSwitch) {
        case 0:
            //int highestValue=(int)[eventToRemoveFrom.friendsInvited count];
            for(i=(int)[eventToRemoveFrom.friendsInvited count]-1;i>=0;i--){
                Friends *tempFriend =  eventToRemoveFrom.friendsInvited[i];
                if(friendToRemove.FriendID == tempFriend.FriendID){
                    [eventToRemoveFrom.friendsInvited removeObject:tempFriend];
                }
            }
            break;
            
        default:
            break;
    }
}
//for friend responce 0= has been invited dont really need this since we only move if they replied to invitation 
//                    1= yes
//                    2= no
//                    3=maybe
-(void)moveFriend:(Event *)thisEvent friend: (Friends *)friendToMove responce:(NSNumber *) friendResponce {
    int theirResponce= [friendResponce intValue];
    if(theirResponce == 1){
        [self removeFriend:thisEvent friend:friendToMove arrayToRemoveFrom:0];
        [thisEvent.friendsGoing addObject:friendToMove];
    }
    else if (theirResponce==2){
        [self removeFriend:thisEvent friend:friendToMove arrayToRemoveFrom:0];
        [thisEvent.friendsNotGoing addObject:friendToMove];
    }
    else{
        [self removeFriend:thisEvent friend:friendToMove arrayToRemoveFrom:0];
        [thisEvent.friendsMightGo addObject:friendToMove];
    }

}

+(Event *)createEvent:(NSString *)eventName des:(NSString *)description eventDate:(NSDate *)date eventTime:(NSInteger *)time PossibleAttendee:(NSMutableArray *)myFriends creator:(User *)event_Creater location:(NSString *)location{
    Event *myEvent = [[Event alloc] init];
    myEvent.nameOfEvent=eventName;
    myEvent.descriptionOfEvent=description;
    myEvent.dateOfEvent=date;
    myEvent.timeofEvent=time;
    myEvent.friendsInvited=myFriends;
    myEvent.location = location;
    //myEvent.creatorOfEvent=event_Creater;
    
    return myEvent;
}


@end
