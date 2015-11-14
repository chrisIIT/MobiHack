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
@synthesize currentUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",currentUser.nickname);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
