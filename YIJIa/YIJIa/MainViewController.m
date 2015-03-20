//
//  MainViewController.m
//  YIJIa
//
//  Created by sven on 3/16/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "MainViewController.h"
#import "CustomSegmentControl.h"
#import "ComMacros.h"
#import "OrderTimeViewController.h"
#import "DateTimeViewController.h"

@interface MainViewController ()
{
    CustomSegmentControl *customSegment;
    
    OrderTimeViewController *vcOrderTime;
    DateTimeViewController *vcDateTime;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initViewControllers];
    [self customSelfUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)initViewControllers
{
    vcOrderTime = [[OrderTimeViewController alloc] initWithNibName:@"OrderTimeViewController" bundle:nil];
    vcOrderTime.view.frame = self.view.bounds;
    vcDateTime = [[DateTimeViewController alloc] initWithNibName:@"DateTimeViewController" bundle:nil];
    vcDateTime.view.frame = self.view.bounds;
    [self.view addSubview:vcDateTime.view];
    [self.view addSubview:vcOrderTime.view];
}

- (void)customSelfUI
{
    customSegment = [[CustomSegmentControl alloc] initWithFrame:CGRectMake(0, 0, APP_Frame_Width, 44)];
    __weak MainViewController *weakSelf = self;
    customSegment.handleSwitchSegment = ^(UIButton *btn){
        [weakSelf segmentChanged:btn];
    };
    if (!customSegment.superview) {
        [self.navigationController.navigationBar addSubview:customSegment];
    }
}

- (void)segmentChanged:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case Button_tag_orderTime:{
            [self.view bringSubviewToFront:vcOrderTime.view];
        }
            break;
        case Button_tag_dateTime:{
            [self.view bringSubviewToFront:vcDateTime.view];
        }
            break;
            
        default:
            break;
    }
}

@end
