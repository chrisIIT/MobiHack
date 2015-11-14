//
//  MainController.m
//  Xcode file
//
//  Created by Alex Thompson on 11/13/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "MainController.h"
#import "CreateEventPage.h"

@interface MainController ()
@property (strong, nonatomic) IBOutlet UITableView *eventsTable;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *NewEvent;

@end

@implementation MainController
@synthesize currentUser,eventsTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    eventsTable.delegate = self;
    eventsTable.dataSource = self;
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
    if(currentUser.eventsInvited != nil){
    return [currentUser.eventsCreated count];
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventsList"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = @"Test";//[currentUser.eventsCreated objectAtIndex:indexPath.row] ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
