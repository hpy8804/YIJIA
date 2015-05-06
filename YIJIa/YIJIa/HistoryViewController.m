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
#import "HistoryDetailViewController.h"
#import "HttpRequest.h"
#import "httpConfigure.h"
#import "HistoryModel.h"
#import "Util.h"

@interface HistoryViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    HttpRequest *_historyRequest;
}
@end

@implementation HistoryViewController

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
    self.title = @"历史纪录";
    self.tableView.tableFooterView = [[UIView alloc] init];
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
//    _historyRequest = [[HttpRequest alloc] initWithDelegate:self];
//    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
//    NSString *strUserName = [defaultUser objectForKey:kUserName];
//    NSString *strReq = kHistoryList(strUserName);
//    [_historyRequest sendRequestWithURLString:strReq];
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *strTechNO = [defaultUser objectForKey:kTech_Number];
    NSDictionary *dic = @{@"techNumber":strTechNO, @"finishStatus":@"1", @"orderType":@"1"};
    [[HttpRequest sharedHttpRequest] postUrl:kHistoryListURL withParam:dic didFinishBlock:^(NSString *strFeedback) {
        NSData * data = [strFeedback dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *array = dataDic[@"list"];
//        _mutArrDatas = [NSMutableArray array];
//        for (int i = 0; i < dataArr.count; i++) {
//            HistoryModel *historyModel = [[HistoryModel alloc] init];
//            historyModel.order_id = dataArr[i][@"ORDER_ID"];
//            historyModel.open_id = dataArr[i][@"OPEN_ID"];
//            historyModel.tech_number = dataArr[i][@"TECH_NUMBER"];
//            historyModel.sub_id = dataArr[i][@"SUB_ID"];
//            historyModel.sub_name = dataArr[i][@"SUB_NAME"];
//            historyModel.person_number = dataArr[i][@"PERSON_NUMBER"];
//            historyModel.subscribe_time = [Util countTimeFromTimeCount:[dataArr[i][@"SUBSCRIBE_TIME"] doubleValue]];
//            historyModel.indent_price = [NSString stringWithFormat:@"%f", [dataArr[i][@"INDENT_PRICE"]doubleValue]];
//            historyModel.pay_status = dataArr[i][@"PAY_STATUS"];
//            historyModel.finish_status = dataArr[i][@"FINISH_STATUS"];
//            historyModel.comment_status = dataArr[i][@"COMMENT_STATUS"];
//            historyModel.coupon_code = dataArr[i][@"COUPON_CODE"];
//            historyModel.cash_status = dataArr[i][@"CASH_STATUS"];
//            historyModel.create_time = [Util countTimeFromTimeCount:[dataArr[i][@"CREATE_TIME"] doubleValue]];
//            historyModel.update_time = [Util countTimeFromTimeCount:[dataArr[i][@"UPDATE_TIME"] doubleValue]];
//            historyModel.address = dataArr[i][@"ADDRESS"];
//            historyModel.mobile = dataArr[i][@"MOBILE"];
//            historyModel.user_name = dataArr[i][@"USER_NAME"];
//            historyModel.length = dataArr[i][@"LENGTH"];
//            historyModel.order_code = dataArr[i][@"ORDER_CODE"];
//            historyModel.delete_status = dataArr[i][@"DELETE_STATUS"];
//            
//            [_mutArrDatas addObject:historyModel];
//        }
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
    cell.order_time.text = [NSString stringWithFormat:@"%@", modelData.subscribe_time];
    cell.adress.text = modelData.address;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HistoryDetailViewController *vcHistoryDetail = [[HistoryDetailViewController alloc] initWithNibName:@"HistoryDetailViewController" bundle:nil];
    vcHistoryDetail.modelHistory = _mutArrDatas[indexPath.row];
    vcHistoryDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcHistoryDetail animated:YES];
}


@end
