//
//  ViewEvent.m
//  Xcode file
//
//  Created by Alex Thompson on 11/14/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "ViewEvent.h"
#import <MapKit/MapKit.h>
#import "Event.h"

@interface ViewEvent ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UILabel *Desc;
@property (strong, nonatomic) IBOutlet UILabel *locationName;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UITableView *friendTable;

@end

@implementation ViewEvent
@synthesize mapView;
@synthesize eventName,Desc,locationName,time,event,friendTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [friendTable.layer setBorderWidth: 1.0];
    [friendTable.layer setCornerRadius:8.0f];
    [friendTable.layer setMasksToBounds:YES];
    [friendTable.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMM d, hh:mm aa"];
    NSString *prettyVersion = [dateFormat stringFromDate:event.dateOfEvent];
    
    mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    eventName.text = event.nameOfEvent;
    Desc.text = event.descriptionOfEvent;
    locationName.text = event.location;
    time.text = prettyVersion;
    
    [self addLeftMenuButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
