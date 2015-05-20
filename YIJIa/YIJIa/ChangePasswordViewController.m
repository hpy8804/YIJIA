//
//  ChangePasswordViewController.m
//  YIJIa
//
//  Created by sven on 5/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "HUD.h"
#import "httpConfigure.h"
#import "HttpRequest.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)clickChangeAction:(id)sender {
    
    if ([_passwordOld.text length] == 0){
        [HUD showUIBlockingIndicatorWithText:@"请输入密码" withTimeout:kTimeoutCount];
        return;
    }else if ([_passwordNew.text length] == 0){
        [HUD showUIBlockingIndicatorWithText:@"请输入新密码" withTimeout:kTimeoutCount];
        return;
    }else if ([_passwordSure.text length] == 0){
        [HUD showUIBlockingIndicatorWithText:@"请输入确认密码" withTimeout:kTimeoutCount];
        return;
    }
    
    if (![_passwordNew.text isEqualToString:_passwordSure.text]){
        [HUD showUIBlockingIndicatorWithText:@"两次输入的密码不一致" withTimeout:kTimeoutCount];
        return;
    }
    
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *strPassword = [defaultUser objectForKey:kUserPassword];
    if (![_passwordOld.text isEqualToString:strPassword]) {
        [HUD showUIBlockingIndicatorWithText:@"旧密码错误" withTimeout:kTimeoutCount];
        return;
    }
    
    NSString *strTechNO = [defaultUser objectForKey:kUserName];
    NSDictionary *dic = @{@"mobile":strTechNO, @"newPwd":_passwordSure.text};
    [[HttpRequest sharedHttpRequest] postUrl:kChangePassword withParam:dic didFinishBlock:^(NSString *strFeedback) {
        NSData * data = [strFeedback dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"success"] boolValue]){
            [HUD showUIBlockingIndicatorWithText:@"修改密码成功" withTimeout:kTimeoutCount];
            [defaultUser setObject:_passwordSure.text forKey:kUserPassword];
            [defaultUser synchronize];

            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [HUD showUIBlockingIndicatorWithText:@"修改密码失败" withTimeout:kTimeoutCount];
        }
    } didFailedBlock:^(NSString *strFeedback) {
        
    }];

}

#pragma mark UITextfield delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _passwordOld) {
        [_passwordNew becomeFirstResponder];
    }else if (textField == _passwordNew){
        [_passwordSure becomeFirstResponder];
    }else{
        [_passwordSure resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

@end
