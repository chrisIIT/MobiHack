//
//  SlideMenuVC.m
//  Xcode file
//
//  Created by Alex Thompson on 11/24/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "SlideMenuVC.h"

@interface SlideMenuVC ()

@end

@implementation SlideMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath{
    NSString *identifier;
    
    switch (indexPath.row) {
        case 0:
            identifier = @"homeSegue";
            break;
        case 1:
            identifier = @"profileSegue";
            break;
        case 2:
            identifier = @"settingsSegue";
            break;
        case 3:
            identifier = @"aboutUsSegue";
            break;
        case 4:
            //logout segue
            break;
        default:
            break;
    }
    return identifier;
}


@end
