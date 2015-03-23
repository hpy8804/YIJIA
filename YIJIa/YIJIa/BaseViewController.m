//
//  BaseViewController.m
//  YIJIa
//
//  Created by sven on 3/16/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "BaseViewController.h"
#import "ComMacros.h"
#import "Util.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavBackgroundImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self resizeForIOS7];
    }
    return self;
}

- (void)customNavBackgroundImage
{
    if (self.navigationController) {
        [Util setNavigationCtrollerBackImg:self.navigationController];
        self.hidesBottomBarWhenPushed = YES;
        self.navigationItem.backBarButtonItem.title = nil;
    }
}

#pragma mark - methods

- (void)resizeForIOS7{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IOS7){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
#endif
}

@end
