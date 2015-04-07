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
@property (weak, nonatomic) IBOutlet UIView *baseWeekView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bottonView;

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
    weekView.frame = _baseWeekView.bounds;
    [_baseWeekView addSubview:weekView];
    
}

@end
