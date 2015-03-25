//
//  TimePlanViewController.m
//  YIJIa
//
//  Created by sven on 3/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "TimePlanViewController.h"
#import "CustomWeekView.h"
#import "ComMacros.h"

@interface TimePlanViewController ()
{
    CustomWeekView *weekView;
}
@end

@implementation TimePlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customSelfUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customSelfUI
{
    self.title = @"时间表";
    weekView = [CustomWeekView detailView];
    weekView.frame = CGRectMake(0, 10, APP_Frame_Width, 50);
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, APP_Frame_Width, 70)];
    headerView.backgroundColor = [UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0];
    [headerView addSubview:weekView];
    _tableView.tableHeaderView = headerView;
}

@end
