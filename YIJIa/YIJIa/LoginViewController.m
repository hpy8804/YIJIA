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

@interface LoginViewController ()<HttpRequestDelegate>
{
    HttpRequest *_loginRequest;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initCurResource];
    [self customSelfUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickLoginAcction:(id)sender {
    NSString *strReq = kLoginAuth(_userName.text, _password.text);
    [_loginRequest sendRequestWithURLString:strReq];
    
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
- (void)initCurResource
{
    _loginRequest = [[HttpRequest alloc] initWithDelegate:self];
}
- (void)loginSucess
{
    //store login data
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    [defaultUser setObject:_userName.text forKey:kUserName];
    [defaultUser setObject:_password.text forKey:kUserPassword];
    [defaultUser synchronize];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self presentViewController:app.tabBarController animated:NO completion:nil];
}

- (void)loginFailed
{
    [HUD showUIBlockingIndicatorWithText:@"用户名或者密码错误" withTimeout:kTimeoutCount];
}

#pragma mark - delegate method

- (void)didFinishRequestWithString:(NSString *)strResult
{
    NSData * data = [strResult dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if ([dataDic[@"result"] isEqualToString:@"true"]) {
        [self loginSucess];
    }else{
        [self loginFailed];
    }
    
}

@end
