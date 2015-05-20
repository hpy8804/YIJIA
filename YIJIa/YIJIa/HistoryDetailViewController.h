//
//  HistoryDetailViewController.h
//  YIJIa
//
//  Created by sven on 3/23/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "BaseViewController.h"
#import "HistoryModel.h"

@interface HistoryDetailViewController : BaseViewController
{
    UIWebView *m_webView;
}
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) HistoryModel *modelHistory;
@property (nonatomic, retain) UIWebView *m_webView;

@end
