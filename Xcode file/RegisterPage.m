//
//  RegisterPage.m
//  Xcode file
//
//  Created by Alex Thompson on 11/14/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "RegisterPage.h"
#import <Parse/Parse.h>

@interface RegisterPage ()
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *repasswordField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UIButton *submit;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) IBOutlet UIButton *changePhotoButton;



@end

@implementation RegisterPage{
    BOOL formDone, passwordsMatchFlag, messageDisplayed;
}
@synthesize usernameField,passwordField,nameField,repasswordField,emailField,submit,userImage,imagePickerController,changePhotoButton;

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

- (IBAction)userSelectingPicture:(id)sender {
    imagePickerController = [[UIImagePickerController alloc]init];
    [imagePickerController setDelegate:(id)self];
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    [self dismissViewControllerAnimated:YES completion:nil];
    [userImage setImage:image];
    [changePhotoButton setTitle:@"" forState:normal];
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
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error!"
                                      message:@"You must enter a valid email."
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
    }else{
        
        //Check if passwords match
        if (![passwordField.text isEqualToString:repasswordField.text]) {
            formDone = NO;
            passwordsMatchFlag = NO;
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Error!"
                                          message:@"Passwords don't match!"
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
            
            NSLog(@" password not the same");
        } else {
            passwordsMatchFlag = YES;
        }
    }
    
    
    // message to tell user must be longer than 4
    if(([usernameField.text length] < 4||[passwordField.text length] < 4) && ([usernameField.text length] != 0||[passwordField.text length] != 0)){
        formDone = NO;
        if(!messageDisplayed){
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Error!"
                                          message:@"Your username and password must be at least 4 characters long."
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
    [self registerUser];
    
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

- (void)registerUser {
    PFUser *user = [PFUser user];
    user.username = usernameField.text;
    user.password = passwordField.text;
    user.email = emailField.text;
    
    // other fields can be set just like with PFObject
    user[@"nick"] = nameField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            [self performSegueWithIdentifier:@"loginUnwind" sender: NULL];
            [self resignFirstResponder];
        } else {   NSString *errorString = [error userInfo][@"error"];
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Error!"
                                          message:errorString
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

@end
