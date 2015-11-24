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
-(void)viewWillDisappear:(BOOL)animated{
    [self reloadInputViews];
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

- (CGFloat)leftMenuWidth
{
    return 250;
}

- (CGFloat)rightMenuWidth
{
    return 180;
}

- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 25, 25);
    button.frame = frame;
    [button setImage:[UIImage imageNamed:@"settings-menu.png"] forState:UIControlStateNormal];
}

- (void) configureSlideLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 5;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:self.view.layer.bounds].CGPath;
}

- (UIViewAnimationOptions) openAnimationCurve {
    return UIViewAnimationOptionCurveEaseOut;
}

- (UIViewAnimationOptions) closeAnimationCurve {
    return UIViewAnimationOptionCurveEaseOut;
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuLeft;
}


// Enabling Deepnes on left menu
- (BOOL)deepnessForLeftMenu
{
    return YES;
}


// Enabling darkness while left menu is opening
- (CGFloat)maxDarknessWhileLeftMenu
{
    return 0.5;
}


@end
