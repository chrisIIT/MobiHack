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

@end

@implementation CreateEventPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
