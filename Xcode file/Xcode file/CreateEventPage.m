//
//  CreateEventPage.m
//  Xcode file
//
//  Created by Alex Thompson on 11/14/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "CreateEventPage.h"

@interface CreateEventPage ()
@property (strong, nonatomic) IBOutlet UITextField *eventNameField;
@property (strong, nonatomic) IBOutlet UITextField *eventDesField;
@property (strong, nonatomic) IBOutlet UITextField *eventLocationField;
@property (strong, nonatomic) IBOutlet UIDatePicker *eventDateTimePicker;
@property (strong, nonatomic) IBOutlet UITableView *friendsTable;
@property (strong, nonatomic) IBOutlet UIButton *doneButoon;


@end

@implementation CreateEventPage
@synthesize currentUser;
@synthesize eventNameField,eventDesField,eventLocationField,eventDateTimePicker,doneButoon;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",currentUser.nickname);
    eventNameField.delegate = self;
    eventLocationField.delegate = self;
    eventDesField.delegate = self;
    [doneButoon setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
- (IBAction)donePress:(id)sender {

    
    [self performSegueWithIdentifier:@"returnHome" sender:currentUser];
}

-(void)checkFields{
    if ([eventNameField.text length] == 0) {
        return;
    } else if ([eventLocationField.text length] == 0) {
        return;
    }
    [doneButoon setEnabled:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [eventLocationField resignFirstResponder];
    [eventDesField resignFirstResponder];
    [eventNameField resignFirstResponder];
    [self checkFields];
    return YES;
}

@end
