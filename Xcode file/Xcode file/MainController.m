//
//  MainController.m
//  Xcode file
//
//  Created by Alex Thompson on 11/13/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "MainController.h"
#import "CreateEventPage.h"
#import "Event.h"
#import "ViewEvent.h"
#import <Parse/Parse.h>

@interface MainController ()
@property (strong, nonatomic) IBOutlet UITableView *eventsTable;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *NewEvent;

@end

@implementation MainController{
    bool AddedEvents;
}
@synthesize currentUser;
@synthesize eventsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    eventsTable.delegate = self;
    eventsTable.dataSource = self;
    AddedEvents = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:@"nsUser"];
    currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    if(currentUser.eventsCreated != NULL){
        AddedEvents = YES;
    }
    NSMutableArray *tempFriends = [[NSMutableArray alloc] init];
    if ([currentUser.friendsArray count] != 0) {
    for (int i; i< [currentUser.friendsArray count] ; i++) {
        PFQuery *query = [PFQuery queryWithClassName:@"User"];
        PFObject *friend =  [query getObjectWithId:currentUser.friendsArray[i]];
        [tempFriends addObject:friend[@"nick"]];
        
        
        
    }
        
        currentUser.friendsArray = tempFriends;
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [eventsTable reloadData];
    if(currentUser.eventsCreated != NULL){
        AddedEvents = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)newEventPress:(id)sender {
    [self performSegueWithIdentifier: @"newEventSegue" sender:currentUser];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([@"newEventSegue" isEqualToString:segue.identifier]) {
        CreateEventPage *controller = (CreateEventPage *) segue.destinationViewController;
        controller.currentUser = sender;
    } else if ([@"toViewEvent" isEqualToString:segue.identifier]) {
        ViewEvent *controller = (ViewEvent *) segue.destinationViewController;
        controller.event = sender;
    }

    
}

-(IBAction)returnHome:(UIStoryboardSegue *)segue {
    if ([segue.identifier isEqualToString:@"returnHome"]) {
        CreateEventPage *returnFromController = (CreateEventPage *)segue.sourceViewController;
        currentUser = returnFromController.currentUser;
    }
}

//Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([currentUser.eventsCreated count] == NULL) {
        return 1;
    }
    
    return [currentUser.eventsCreated count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeSlideViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    if(currentUser.eventsCreated == NULL){
    cell.textLabel.text = @"Add an Event!"; //[nameTableArray objectAtIndex:indexPath.row] ;
    }else{
        Event *tempEvent = currentUser.eventsCreated[indexPath.row];
        cell.textLabel.text = tempEvent.nameOfEvent;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (AddedEvents) {
        [self performSegueWithIdentifier:@"toViewEvent" sender:currentUser.eventsCreated[indexPath.row]];
    }
}
@end
