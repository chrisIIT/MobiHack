//
//  User.m
//  Xcode file
//
//  Created by Davvid Caballero on 11/13/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize username,eventsCreated,eventsInvited,password;

-(void)changeUsername:(NSString *)newUsername{
    username = newUsername;
}

-(void)changePassword:(NSString *)newPassword{
    password=newPassword;
}

-(void)createEvent:(NSString *)eventName des: (NSString *)description :(NSNumber *) time{
    
}
@end
