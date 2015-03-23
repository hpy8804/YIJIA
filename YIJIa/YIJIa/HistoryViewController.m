//
//  HistoryViewController.m
//  YIJIa
//
//  Created by sven on 3/16/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryViewCell.h"
#import "MJRefresh.h"

@interface HistoryViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customSelfUI];
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)customSelfUI
{
    self.title = @"历史纪录";
}

- (void)setupRefresh{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"tabledate"];
}

- (void)headerRereshing{
    [self fetchHistoryData];
}

- (void)fetchHistoryData
{
    [self.tableView headerEndRefreshing];
}

#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strIndentifier = @"HistoryViewCell";
    HistoryViewCell *cell = [HistoryViewCell reuseableCell:tableView WithCellIdentifier:strIndentifier];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
