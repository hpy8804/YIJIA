//
//  SettingViewController.m
//  YIJIa
//
//  Created by sven on 3/16/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "SettingViewController.h"
#import "TimePlanViewController.h"
#import "HttpRequest.h"
#import "httpConfigure.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "HUD.h"

@interface SettingViewController ()
{
    NSArray *arrAllDatas;
    HttpRequest *requestHttp;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self sendRequest];
    [self initSelfData];
    [self customSelfUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)sendRequest
{
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *strTechNO = [defaultUser objectForKey:kTech_Number];
    NSDictionary *dic = @{@"techNumber":strTechNO};
    [[HttpRequest sharedHttpRequest] postUrl:kTechInfoURL withParam:dic didFinishBlock:^(NSString *strFeedback) {
        NSData * data = [strFeedback dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *tech_info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if ([tech_info[@"success"] boolValue]){
            _name.text = tech_info[@"list"][0][@"TECH_NAME"];
            _age.text = [NSString stringWithFormat:@"%d岁", [tech_info[@"list"][0][@"TECH_AGE"] integerValue]];
            _location.text = tech_info[@"list"][0][@"ADDRESS"];
            NSString *strTechInfo = tech_info[@"list"][0][@"TECH_INTRO"];
            NSRange range = [strTechInfo rangeOfString:@"经验"];
            _experience.text = [strTechInfo substringToIndex:range.location+range.length];
            _finishedWork.text = [NSString stringWithFormat:@"%d单", [tech_info[@"list"][1][@"COUNT"] integerValue]];
        }
        
    } didFailedBlock:^(NSString *strFeedback) {
        
    }];
    
    //obtain portrait
    NSString *strURL = [NSString stringWithFormat:@"%@?techNumber=%@", kTechPortrait, strTechNO];
    [_portrait sd_setImageWithURL:[NSURL URLWithString:strURL] placeholderImage:[UIImage imageNamed:@"默认用户头像"]];
    
}
- (void)initSelfData
{
    arrAllDatas = @[@"时间安排", @"我的二维码", @"检查更新", @"退出登录"];
}

- (void)customSelfUI
{
    self.title = @"设置";
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollEnabled = NO;
    
    _portrait.layer.masksToBounds = YES;
    _portrait.layer.cornerRadius = _portrait.frame.size.width/2.0;
}

#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrAllDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strIndentifier = @"SettingViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIndentifier];
    }
    cell.textLabel.text = arrAllDatas[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            TimePlanViewController *vcTimePlan = [[TimePlanViewController alloc] initWithNibName:@"TimePlanViewController" bundle:nil];
            vcTimePlan.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vcTimePlan animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            [HUD showUIBlockingIndicatorWithText:@"当前已是最新版本!" withTimeout:kTimeoutCount];
        }
            break;
        case 3:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"确定要退出登录吗?"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
            [alertView show];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIAlertView delegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.tabBarController dismissViewControllerAnimated:NO completion:^{
            [app customTabbarController];
        }];
    }
}
@end
