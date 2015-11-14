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
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)loginButtonOnPress:(id)sender {
    [PFUser logInWithUsernameInBackground: usernameField.text password:passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            User *tempUser = [[User alloc] init];
                                            tempUser.username = user.username;
                                            tempUser.nickname = user[@"nick"];
                                            
                                            [self performSegueWithIdentifier:@"homeSegue" sender: tempUser];
                                        } else {
                                            UIAlertController * alert=   [UIAlertController
                                                                          alertControllerWithTitle:@"Error!"
                                                                          message:@"Usernam/Password Incorrect!"
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"homeSegue"]) {
        MainController *controller = (MainController *) segue.destinationViewController;
        controller.currentUser = sender;
        
    }
}

@end
