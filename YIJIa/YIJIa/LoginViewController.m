//
//  LoginViewController.m
//  YIJIa
//
//  Created by sven on 3/19/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "HttpRequest.h"
#import "httpConfigure.h"
#import "HUD.h"

@interface LoginViewController ()
{
    HttpRequest *_loginRequest;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customSelfUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickLoginAcction:(id)sender {
    k_WeakSelf
    NSDictionary *dic = @{@"mobile":_userName.text, @"password":_password.text};
    [[HttpRequest sharedHttpRequest] postUrl:kLoginURL withParam:dic didFinishBlock:^(NSString *strFeedback) {
        NSData * data = [strFeedback dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"success"] boolValue]) {
            [weakSelf loginSucessWithInfo:dic];
        }else {
            [weakSelf loginFailed];
        }
    } didFailedBlock:^(NSString *strFeedback) {
        
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userName resignFirstResponder];
    [_password resignFirstResponder];
    
    return YES;
}
#pragma mark -

- (void)customSelfUI
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    _userName.text = [userDefault objectForKey:kUserName];
    _password.text = [userDefault objectForKey:kUserPassword];
    
    if ([_userName.text length] != 0 && [_password.text length] != 0) {
        [self clickLoginAcction:nil];
    }
}

- (void)loginSucessWithInfo:(NSDictionary *)dataInfo
{
    //store login data
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    [defaultUser setObject:_userName.text forKey:kUserName];
    [defaultUser setObject:_password.text forKey:kUserPassword];
    [defaultUser setObject:dataInfo[@"obj"][kTech_Number] forKey:kTech_Number];
    [defaultUser synchronize];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self presentViewController:app.tabBarController animated:NO completion:nil];
}

- (void)loginFailed
{
    [HUD showUIBlockingIndicatorWithText:@"用户名或者密码错误" withTimeout:kTimeoutCount];
}

@end
