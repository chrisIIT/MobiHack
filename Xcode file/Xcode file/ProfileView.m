//
//  ProfileView.m
//  Xcode file
//
//  Created by Alex Thompson on 11/24/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "ProfileView.h"
#import "User.h"
#import "Friends.h"

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
    [self findFriend:friendsSearch.text];
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

-(void) findFriend: (NSString *) userNameSearch{
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"username" equalTo:userNameSearch];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:userNameSearch
                                          message:@"User was found."
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* addButton = [UIAlertAction
                                       actionWithTitle:@"Add"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                          
                                           /*
                                                set up push notifications
                                                Add code to allow for users to accept friend requests
                                                change code so user isnt auto added when user is add to searching user
                                            */
                                           PFObject *friendObject = objects[0];
                                           Friends *newFriend = [[Friends alloc] init];
                                           newFriend.friendID = friendObject.objectId;
                                           newFriend.friendUsername = userNameSearch;
                                           
                                           if(currentUser.friendsArray != NULL){
                                               [currentUser.friendsArray addObject:newFriend];
                                           }
                                           else{
                                               currentUser.friendsArray = [[NSMutableArray alloc] init];
                                               [currentUser.friendsArray addObject:newFriend];
                                           }
                                           NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:currentUser];
                                           NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                           [defaults setObject:encodedObject forKey:@"nsUser"];
                                           [defaults synchronize];
                                           
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                           
                                       }];
            
            UIAlertAction* cancelButton = [UIAlertAction
                                        actionWithTitle:@"Cancel"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            //Handel your yes please button action here
                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                            
                                        }];

            
            
            [alert addAction:addButton];
            [alert addAction:cancelButton];
            
            [self presentViewController:alert animated:YES completion:nil];

        } else {
            // Log details of the failure
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Error!"
                                          message:@"Couldn't Connect to Network"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* okButton = [UIAlertAction
                                       actionWithTitle:@"Okay"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           //Handel your yes please button action here
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                           
                                       }];
            
            
            [alert addAction:okButton];
            
            [self presentViewController:alert animated:YES completion:nil];

        }
    }];
    
}

-(IBAction)backToProfile:(UIStoryboardSegue *)segue {
    
}


@end
