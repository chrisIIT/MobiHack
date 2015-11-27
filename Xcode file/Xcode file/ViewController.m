//
//  ViewController.m
//  Xcode file
//
//  Created by Davvid Caballero on 11/13/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "User.h"
#import "MainController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation ViewController
@synthesize loginButton;
@synthesize passwordField,usernameField;
- (void)viewDidLoad {
    [super viewDidLoad];
    passwordField.delegate = self;
    usernameField.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)loginButtonOnPress:(id)sender {
    [PFUser logInWithUsernameInBackground: usernameField.text password:passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            User *tempUser = [[User alloc] init];
                                            tempUser.username = user.username;
                                            tempUser.nickname = user[@"nick"];
                                            tempUser.friendsArray = user[@"friends"];
                                            tempUser.eventsInvited = user[@"eventsInvited"];
                                            tempUser.eventsCreated = user[@"eventsCreated"];
                                            
                                            NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:tempUser];
                                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                            [defaults setObject:encodedObject forKey:@"nsUser"];
                                            [defaults synchronize];
                                            
                                            [self performSegueWithIdentifier:@"homeSegue" sender: NULL];//tempUser];
                                        } else {
                                            UIAlertController * alert=   [UIAlertController
                                                                          alertControllerWithTitle:@"Error!"
                                                                          message:@"Username/Password Incorrect!"
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
                                            
                                            [self presentViewController:alert animated:YES completion:nil];                                        }
                                    }];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    usernameField.text = @"" ;
    passwordField.text = @"" ;
    [self resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
}
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString:@"homeSegue"]) {
//        MainController *controller = (MainController *) segue.destinationViewController;
//        controller.currentUser = sender;
//        
//    }
//}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up {
    int movementDistance;
    float movementDuration;
    

        movementDistance = -150; // tweak as needed
        movementDuration = 0.3f; // tweak as needed
    
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(IBAction)logout:(UIStoryboardSegue *)segue {
    
}

@end
