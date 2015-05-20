//
//  AddCommentViewController.m
//  YIJIa
//
//  Created by sven on 5/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "AddCommentViewController.h"

@interface AddCommentViewController ()

@end

@implementation AddCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户备注";
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    _addComment.text = [defaultUser objectForKey:[NSString stringWithFormat:@"comment:%@", self.order_id]];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    [defaultUser setObject:_addComment.text forKey:[NSString stringWithFormat:@"comment:%@", self.order_id]];
    [defaultUser synchronize];
}

@end
