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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickLoginAcction:(id)sender {
    [_loginRequest sendRequestWithURLString:@"http://121.41.47.120/backend_service/test/getData.do"];
    
}
#pragma mark -
- (void)initCurResource
{
    _loginRequest = [[HttpRequest alloc] initWithDelegate:self];
}
- (void)loginSucess
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self presentViewController:app.tabBarController animated:NO completion:nil];
}

#pragma mark - delegate method

- (void)didFinishRequestWithString:(NSString *)strResult
{
    NSData * data = [strResult dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"strResult:%@", dataDic);
}

@end
