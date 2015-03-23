//
//  HistoryDetailViewController.m
//  YIJIa
//
//  Created by sven on 3/23/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "HistoryDetailViewController.h"

@interface HistoryDetailViewController ()
{
    NSArray *_arrData;
}
@end

@implementation HistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customSelfData];
    [self customSelfUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)customSelfData
{
    _arrData = @[@[@{@"dajunze":@"18116144722"}, @{@"预约时间":@"01月24日 16:00"}, @{@"服务地址":@"徐汇区中山南二路1057弄协昌小区4号楼103室"}],
                 @[@{@"优惠券":@"新手礼券 ¥88.00"}, @{@"服务收入":@"¥38.00"}],
                 @[@{@"下单时间":@"01月24日 16:00"}]];
}
- (void)customSelfUI
{
    self.title = @"订单详情";
}

#pragma mark - tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 3;
        }
            break;
        case 1:
        {
            return 3;
        }
            break;
        case 2:
        {
            return 4;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strIndentifier = @"HistoryViewDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strIndentifier];
    }
    cell.textLabel.text = @"hello test";
    cell.detailTextLabel.text = @"telephone";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:_detailTableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
