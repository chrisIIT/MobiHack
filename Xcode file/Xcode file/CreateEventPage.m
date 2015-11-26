//
//  CreateEventPage.m
//  Xcode file
//
//  Created by Alex Thompson on 11/14/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "CreateEventPage.h"
#import "Event.h"
#import "User.h"
#import <Parse/Parse.h>

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
@synthesize eventNameField,eventDesField,eventLocationField,eventDateTimePicker,doneButoon,friendsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",currentUser.nickname);
    eventNameField.delegate = self;
    eventLocationField.delegate = self;
    eventDesField.delegate = self;
    [doneButoon setEnabled:NO];
    
    [friendsTable.layer setBorderWidth: 1.0];
    [friendsTable.layer setCornerRadius:8.0f];
    [friendsTable.layer setMasksToBounds:YES];
    [friendsTable.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
- (IBAction)donePress:(id)sender {
    
    
    if(!currentUser.eventsCreated){
        currentUser.eventsCreated = [[NSMutableArray alloc ]init];
        Event *tempEvent = [[Event alloc] init];
        tempEvent =[Event createEvent:eventNameField.text des:eventDesField.text eventDate:eventDateTimePicker.date eventTime:NULL PossibleAttendee:NULL creator:currentUser location:eventLocationField.text];
        [currentUser.eventsCreated addObject:tempEvent];
    }
    else{
        Event *tempEvent = [[Event alloc] init];
        tempEvent =[Event createEvent:eventNameField.text des:eventDesField.text eventDate:eventDateTimePicker.date eventTime:NULL PossibleAttendee:NULL creator:currentUser location:eventLocationField.text];
        [currentUser.eventsCreated addObject:tempEvent];
    }
    
    PFObject *newEvent = [PFObject objectWithClassName:@"Event"];
    newEvent[@"date"] = eventDateTimePicker.date;
    newEvent[@"name"] = eventNameField.text;
    newEvent[@"descripion"] = eventDesField.text;
    newEvent[@"location"] = eventLocationField.text;
    [newEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [newEvent fetch];
            //add code to instert 
//            if(){
//                
//            }
            [self performSegueWithIdentifier:@"returnHome" sender:currentUser];
        } else {
            // There was a problem, check error.description
        }
    }];

    
    
    
    //[self performSegueWithIdentifier:@"returnHome" sender:currentUser];
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
