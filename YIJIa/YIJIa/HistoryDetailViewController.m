//
//  HistoryDetailViewController.m
//  YIJIa
//
//  Created by sven on 3/23/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "HistoryDetailViewController.h"
#import "ComMacros.h"
#import "httpConfigure.h"
#import "HttpRequest.h"
#import "UIImageView+WebCache.h"
#import <MessageUI/MessageUI.h>
#import "CommentViewController.h"
#import "AddCommentViewController.h"

#define kImgCellHeight 120

@interface HistoryDetailViewController ()<MFMessageComposeViewControllerDelegate>
{
    NSString *strComment;
    UIButton *btnCall;
    UIButton *btnSMS;
}
@end

@implementation HistoryDetailViewController
@synthesize m_webView;

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

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_detailTableView reloadData];
}
- (void)customSelfUI
{
    self.title = @"订单详情";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.m_webView = webView;
    
    btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCall setFrame:CGRectMake(240, 7, 30, 30)];
    [btnCall setImage:PNGIMAGE(@"电话图标") forState:UIControlStateNormal];
    [btnCall addTarget:self action:@selector(handleCallAction) forControlEvents:UIControlEventTouchUpInside];
    
    btnSMS = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSMS setFrame:CGRectMake(280, 7, 30, 30)];
    [btnSMS setImage:PNGIMAGE(@"信息") forState:UIControlStateNormal];
    [btnSMS addTarget:self action:@selector(showMessageView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleCallAction
{
    NSString *telStr=[[NSString alloc]initWithFormat:@"%@%@",@"tel://",_modelHistory.mobile];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:telStr]];
    [m_webView loadRequest:request];
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
            return 5;
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
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    cell.detailTextLabel.text = nil;
    cell.imageView.image = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", _modelHistory.user_name, _modelHistory.mobile];
                [cell.contentView addSubview:btnCall];
                [cell.contentView addSubview:btnSMS];
            }
                break;
            case 1:
            {
                cell.imageView.image = [UIImage imageNamed:@"预约时间图标"];
                cell.textLabel.text = @"预约时间";
                cell.detailTextLabel.text = _modelHistory.create_time;
            }
                break;
            case 2:
            {
                cell.imageView.image = [UIImage imageNamed:@"服务地址图标"];
                cell.textLabel.text = @"服务地址";
                cell.detailTextLabel.numberOfLines = 2;
                cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
                cell.detailTextLabel.text = _modelHistory.address;
            }
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_Frame_Width, kImgCellHeight-1)];
                [cell.contentView addSubview:imgView];
                NSString *strURL = [NSString stringWithFormat:@"http://www.meiyanmeijia.com/wx/aiyijia/subject-image.jsp?subId=%@", _modelHistory.sub_id];
                [imgView sd_setImageWithURL:[NSURL URLWithString:strURL] placeholderImage:nil];
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"优惠券";
                cell.detailTextLabel.text = @"未使用";
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"服务价格";
                cell.detailTextLabel.text = _modelHistory.indent_price;
            }
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"下单时间";
                cell.detailTextLabel.text = _modelHistory.create_time;
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"付款状态";
                switch ([_modelHistory.pay_status intValue]) {
                    case 0:
                    {
                        cell.detailTextLabel.text = @"未支付";
                    }
                        break;
                    case 1:
                    {
                        cell.detailTextLabel.text = @"已支付";
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"订单状态";
                cell.detailTextLabel.text = @"已完成";
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"用户评价";
                cell.detailTextLabel.text = strComment;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
                break;
            case 4:
            {
                cell.textLabel.text = @"添加备注";
                NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
                cell.detailTextLabel.text = [defaultUser objectForKey:[NSString stringWithFormat:@"comment:%@", _modelHistory.order_id]];;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && (indexPath.row == 0)) {
        return kImgCellHeight;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        if (indexPath.row == 3) {
            CommentViewController *vcComment = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
            vcComment.order_id = _modelHistory.order_id;
            [self.navigationController pushViewController:vcComment animated:YES];
        }else if (indexPath.row == 4){
            AddCommentViewController *vcAddComment = [[AddCommentViewController alloc] initWithNibName:@"AddCommentViewController" bundle:nil];
            vcAddComment.order_id = _modelHistory.order_id;
            [self.navigationController pushViewController:vcAddComment animated:YES];
        }
    }
}

#pragma mark delegate -
- (void)didFinishRequestWithString:(NSString *)strResult
{
    NSData * data = [strResult dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    strComment = dataArr[@"CONTENT"];
    [self.detailTableView reloadData];
}


- (void)showMessageView
{
    
    if( [MFMessageComposeViewController canSendText] ){
        
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:_modelHistory.mobile];
        controller.body = @"";
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"测试短信"];//修改短信界面标题
    }else{
        
        [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
    }
}


//MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [controller dismissViewControllerAnimated:NO completion:nil];
    
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:// send failed
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        default:
            break;
    }
}


- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    
    [alert show];  
    
}

@end
