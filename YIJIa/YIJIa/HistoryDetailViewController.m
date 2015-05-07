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

#define kImgCellHeight 120

@interface HistoryDetailViewController ()
{
    NSString *strComment;
}
@end

@implementation HistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customSelfData];
    [self customSelfUI];
    [self fetchComment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)customSelfData
{

}
- (void)customSelfUI
{
    self.title = @"订单详情";
}

- (void)fetchComment
{
//    HttpRequest *_historyRequest = [[HttpRequest alloc] initWithDelegate:self];
//    NSString *strReq = kComment(_modelHistory.order_id);
//    [_historyRequest sendRequestWithURLString:strReq];
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
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = _modelHistory.user_name;
                cell.detailTextLabel.text = _modelHistory.mobile;
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
                cell.textLabel.text = @"订单状态";
                cell.detailTextLabel.text = @"已完成";
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"用户评价";
                cell.detailTextLabel.text = strComment;
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"添加备注";
                cell.detailTextLabel.text = @"这是个新客户，没有产品使用经验，可以忽悠";
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
    
}

#pragma mark delegate -
- (void)didFinishRequestWithString:(NSString *)strResult
{
    NSData * data = [strResult dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    strComment = dataArr[@"CONTENT"];
    [self.detailTableView reloadData];
}

@end
