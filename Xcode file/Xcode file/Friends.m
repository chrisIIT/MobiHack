//
//  Friends.m
//  Xcode file
//
//  Created by Davvid Caballero on 11/14/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "Friends.h"

@implementation Friends
@synthesize friendUsername,friendID;


- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.friendID forKey:@"friendID"];
    [encoder encodeObject:self.friendUsername forKey:@"friendUsername"];

}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        // decode properties, other class vars
        self.friendID = [decoder decodeObjectForKey:@"friendID"];
        self.friendUsername = [decoder decodeObjectForKey:@"friendUsername"];

    }
    return self;
}


@end
