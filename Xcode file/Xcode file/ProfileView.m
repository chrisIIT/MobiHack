//
//  ProfileView.m
//  Xcode file
//
//  Created by Alex Thompson on 11/24/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "ProfileView.h"
#import "User.h"

@interface ProfileView ()
@property IBOutlet UITableView *friendsTable;
@property IBOutlet UITextField *friendsSearch;
@property IBOutlet UIButton *searchFriend;
@property IBOutlet UILabel *userName;
@property User* currentUser;
@end

@implementation ProfileView
@synthesize friendsTable, friendsSearch, searchFriend, userName;
@synthesize currentUser;


- (void)viewDidLoad {
    [super viewDidLoad];
    searchFriend.hidden = YES;
    [friendsSearch setDelegate:self];
    
    NSUserDefaults *nsUser = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [nsUser objectForKey:@"nsUser"];
    currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendRequestPressed:(id)sender {
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [friendsSearch resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField:textField up:NO];
    if([textField.text length] > 3){
        searchFriend.hidden = NO;
    }
    else{
        searchFriend.hidden = YES;
    }
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up {
    int movementDistance;
    float movementDuration;
    
        movementDistance = -225; // tweak as needed
        movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if([textField.text length] > 3){
//         searchFriend.hidden = NO;
//    }
//    else{
//        searchFriend.hidden = YES;
//    }
//    
//    return YES;
//}


@end
