//
//  CommentViewController.m
//  YIJIa
//
//  Created by sven on 5/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "CommentViewController.h"
#import "HttpRequest.h"
#import "httpConfigure.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"用户评价";
    [self fetchComment];
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

- (void)fetchComment
{
    NSDictionary *dic = @{@"orderId":self.order_id};
    [[HttpRequest sharedHttpRequest] postUrl:kGetComment withParam:dic didFinishBlock:^(NSString *strFeedback) {
        NSData * data = [strFeedback dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if ([dataDic[@"success"] boolValue])
        {
            if (!dataDic[@"obj"]) {
                _commentTextView.text = @"没有评价";
            }else{
                _commentTextView.text = dataDic[@"obj"];;
            }
        }else{
            _commentTextView.text = @"没有评价";
        }
        
    } didFailedBlock:^(NSString *strFeedback) {
        
    }];
    
}

@end
