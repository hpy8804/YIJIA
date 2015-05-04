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
//    requestHttp = [[HttpRequest alloc] initWithDelegate:self];
//    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
//    NSString *strUserNO = [defaultUser objectForKey:kTech_Number];
//    NSString *strReq = kTechnician_info(strUserNO);
//    [requestHttp sendRequestWithURLString:strReq];
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

#pragma mark delegate -
- (void)didFinishRequestWithString:(NSString *)strResult
{
    NSData * data = [strResult dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *tech_info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    _name.text = tech_info[@"list"][0][@"TECH_NAME"];
    _age.text = [NSString stringWithFormat:@"%d岁", [tech_info[@"list"][0][@"TECH_AGE"] integerValue]];
    _location.text = tech_info[@"list"][0][@"ADDRESS"];
    _experience.text = [tech_info[@"list"][0][@"TECH_INTRO"] substringToIndex:6];
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
