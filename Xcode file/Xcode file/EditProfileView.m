//
//  EditProfileView.m
//  Xcode file
//
//  Created by Alex Thompson on 11/24/15.
//  Copyright © 2015 Davvid Caballero. All rights reserved.
//

#import "EditProfileView.h"

@interface EditProfileView ()

@end

@implementation EditProfileView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                             target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                             target:self action:@selector(save)];


}
-(void)save{
    //add code to update user profile
    
    
    [self performSegueWithIdentifier:@"backToProfileSegue" sender:NULL];
}
-(void)back{
    [self performSegueWithIdentifier:@"backToProfileSegue" sender:NULL];
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
