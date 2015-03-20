//
//  LoginViewController.m
//  YIJIa
//
//  Created by sven on 3/19/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickLoginAcction:(id)sender {
    [self performSelector:@selector(loginSucess) withObject:nil afterDelay:1.0];
}
#pragma mark -
- (void)loginSucess
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self presentViewController:app.tabBarController animated:NO completion:nil];
}

@end
