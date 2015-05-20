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
#import "HistoryDetailViewController.h"
#import "HistoryViewCell.h"
#import "MJRefresh.h"
#import "HistoryDetailViewController.h"
#import "HttpRequest.h"
#import "httpConfigure.h"
#import "HistoryModel.h"
#import "Util.h"
#import "UIImageView+WebCache.h"

@interface MainViewController ()
{
    CustomSegmentControl *customSegment;
    BOOL bIsOrderTime;
    BOOL bIsDateTime;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self customSelfUI];
    [self setupRefresh];
    [self fetchDataFirst];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)customSelfUI
{
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.navigationController.delegate = self;
    customSegment = [[CustomSegmentControl alloc] initWithFrame:CGRectMake(0, 0, APP_Frame_Width, 44)];
    __weak MainViewController *weakSelf = self;
    customSegment.handleSwitchSegment = ^(UIButton *btn){
        [weakSelf segmentChanged:btn];
    };
    if (!customSegment.superview) {
        [self.navigationController.navigationBar addSubview:customSegment];
    }
    
    bIsOrderTime = NO;
    bIsDateTime = NO;
}

- (void)segmentChanged:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case Button_tag_orderTime:{
            bIsOrderTime = YES;
            bIsDateTime = NO;
        }
            break;
        case Button_tag_dateTime:{
            bIsOrderTime = NO;
            bIsDateTime = YES;
        }
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - UINavigationController delegate method
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        if (!customSegment.superview) {
            [self.navigationController.navigationBar addSubview:customSegment];
        }
    }else{
        [customSegment removeFromSuperview];
    }
}

- (void)setupRefresh{
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing) dateKey:@"tabledate"];
}

- (void)headerRereshing{
    [self fetchHistoryData];
}

- (void)fetchDataFirst
{
    [self.tableView headerBeginRefreshing];
    [self fetchHistoryData];
    
}

- (void)fetchHistoryData
{
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *strTechNO = [defaultUser objectForKey:kTech_Number];
    NSDictionary *dic = @{@"techNumber":strTechNO, @"finishStatus":@"0", @"orderType":@"1"};
    [[HttpRequest sharedHttpRequest] postUrl:kHistoryListURL withParam:dic didFinishBlock:^(NSString *strFeedback) {
        NSData * data = [strFeedback dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *dataArr = dataDic[@"list"][0];
        NSArray *dataDetailArr = dataDic[@"list"][3];
        _mutArrDatas = [NSMutableArray array];
        for (int i = 0; i < dataArr.count; i++) {
            NSDictionary *subDic = dataArr[i];
            if (![[subDic allKeys] containsObject:@"ADDRESS"]) {
                continue;
            }
            HistoryModel *historyModel = [[HistoryModel alloc] init];
            historyModel.order_id = dataArr[i][@"ORDER_ID"];
            historyModel.open_id = dataArr[i][@"OPEN_ID"];
            historyModel.tech_number = dataArr[i][@"TECH_NUMBER"];
            historyModel.sub_id = dataDetailArr[i][0][@"SUB_ID"];
            historyModel.sub_name = dataDetailArr[i][0][@"SUB_NAME"];
            historyModel.person_number = dataArr[i][@"PERSON_NUMBER"];
            historyModel.subscribe_time = [Util countTimeFromTimeCount:[dataArr[i][@"SUBSCRIBE_TIME"] doubleValue]];
            historyModel.indent_price = [NSString stringWithFormat:@"%.1f", [dataArr[i][@"INDENT_PRICE"]doubleValue]];
            historyModel.pay_status = dataArr[i][@"PAY_STATUS"];
            historyModel.pay_type = dataArr[i][@"PAY_TYPE"];
            historyModel.finish_status = dataArr[i][@"FINISH_STATUS"];
            historyModel.comment_status = dataArr[i][@"COMMENT_STATUS"];
            historyModel.coupon_code = dataArr[i][@"COUPON_CODE"];
            historyModel.cash_status = dataArr[i][@"CASH_STATUS"];
            historyModel.create_time = [Util countTimeFromTimeCount:[dataArr[i][@"CREATE_TIME"] doubleValue]];
            historyModel.update_time = [Util countTimeFromTimeCount:[dataArr[i][@"UPDATE_TIME"] doubleValue]];
            historyModel.address = dataArr[i][@"ADDRESS"];
            historyModel.mobile = dataArr[i][@"MOBILE"];
            historyModel.user_name = dataArr[i][@"USER_NAME"];
            historyModel.length = dataArr[i][@"LENGTH"];
            historyModel.order_code = dataArr[i][@"ORDER_CODE"];
            historyModel.delete_status = dataArr[i][@"DELETE_STATUS"];
            
            [_mutArrDatas addObject:historyModel];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } didFailedBlock:^(NSString *strFeedback) {
        
    }];
}



#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mutArrDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strIndentifier = @"HistoryViewCell";
    HistoryViewCell *cell = [HistoryViewCell reuseableCell:tableView WithCellIdentifier:strIndentifier];
    HistoryModel *modelData = _mutArrDatas[indexPath.row];
    cell.sub_name.text = modelData.sub_name;
    cell.price.text = [NSString stringWithFormat:@"%@元", modelData.indent_price];
    if (bIsOrderTime) {
        cell.order_time.text = [NSString stringWithFormat:@"%@", modelData.create_time];
    }else if (bIsDateTime){
        cell.order_time.text = [NSString stringWithFormat:@"%@", modelData.subscribe_time];
    }
    
    cell.adress.text = modelData.address;
    switch ([modelData.pay_type integerValue]) {
        case 1:
        {
            cell.payType.text = @"现金支付";
        }
            break;
        case 2:
        {
            cell.payType.text = @"微信支付";
        }
            break;
        case 3:
        {
            cell.payType.text = @"套餐支付";
        }
            break;
            
        default:
            break;
    }
    
    NSString *strURL = [NSString stringWithFormat:@"http://www.meiyanmeijia.com/wx/aiyijia/subject-image2.jsp?subId=%@", modelData.sub_id];
    [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:strURL] placeholderImage:nil];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HistoryModel *model = _mutArrDatas[indexPath.row];
    HistoryDetailViewController *vcHistoryDetail = [[HistoryDetailViewController alloc] initWithNibName:@"HistoryDetailViewController" bundle:nil];
        vcHistoryDetail.modelHistory = model;
        vcHistoryDetail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcHistoryDetail animated:YES];
}


@end
