//
//  RegisterPage.m
//  Xcode file
//
//  Created by Alex Thompson on 11/14/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "RegisterPage.h"

@interface RegisterPage ()
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *repasswordField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UIButton *submit;


@end

@implementation RegisterPage{
    BOOL formDone, passwordsMatchFlag, messageDisplayed;
}
@synthesize usernameField,passwordField,nameField,repasswordField,emailField,submit;

- (void)viewDidLoad {
    [super viewDidLoad];
    formDone= NO;
    passwordsMatchFlag = NO;
    messageDisplayed = NO;
    submit.enabled = NO;
    
    usernameField.delegate = self;
    nameField.delegate = self;
    passwordField.delegate = self;
    repasswordField.delegate = self;
    emailField.delegate = self;
    
    
    passwordField.secureTextEntry = YES;
    repasswordField.secureTextEntry = YES;
    
    [self checkFields];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)checkFields{
    if ([usernameField.text length] == 0) {
        formDone = NO;
        return;
    } else if ([passwordField.text length] == 0) { // changed username length
        formDone = NO;
        return;
    } else if ([repasswordField.text length] == 0) { //changed password length size
        formDone = NO;
        return;
    } else if ([nameField.text length] == 0) {
        formDone = NO;
        return;
    }
    else if ([emailField.text length] == 0) {
        formDone = NO;
        return;
    }
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if([emailTest evaluateWithObject:self.emailField.text] == NO)
    {
        formDone = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You must enter valid email address."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        
        //Check if passwords match
        if (![passwordField.text isEqualToString:repasswordField.text]) {
            formDone = NO;
            passwordsMatchFlag = NO;
//            passwordField.text = @"Password Different!";
//            .textColor = [UIColor redColor];
            NSLog(@" password not the same");
        } else {
            passwordsMatchFlag = YES;
//            passwordMatch1.text = @"Passwords Match!";
//            passwordMatch1.textColor = [UIColor greenColor];
        }
    }
    
    
    // message to tell user must be longer than 4
    if(([usernameField.text length] < 4||[passwordField.text length] < 4) && ([usernameField.text length] != 0||[passwordField.text length] != 0)){
        formDone = NO;
        if(!messageDisplayed){
//            UIAlertActionStyle *alert = [[UIAlertActionStyle alloc] initWithTitle:@"Error"
//                                                            message:@"Your username and password must be at least 4 characters long."
//                                                           delegate:self
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//            [alert show];
            NSLog(@" username not long enough");
        }
        messageDisplayed = YES;
    }
    else if (passwordsMatchFlag){
        formDone = YES;
        [submit setEnabled:YES];
    }
    
    if(formDone == NO) {
        [submit setEnabled:NO];
    }
}



- (IBAction)submitButtonPress:(id)sender {

    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    [repasswordField resignFirstResponder];
    [emailField resignFirstResponder];
    [nameField resignFirstResponder];
    [self checkFields];
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
    
    if(textField == emailField){
    movementDistance = -200; // tweak as needed
    movementDuration = 0.3f; // tweak as needed
        
    }else{
        movementDistance = -150; // tweak as needed
        movementDuration = 0.3f; // tweak as needed

    }
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)myMethod {
//    PFUser *user = [PFUser user];
//    user.username = @"my name";
//    user.password = @"my pass";
//    user.email = @"email@example.com";
//    
//    // other fields can be set just like with PFObject
//    user[@"phone"] = @"415-392-0202";
//    
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {   // Hooray! Let them use the app now.
//        } else {   NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
//        }
//    }];
}

@end
