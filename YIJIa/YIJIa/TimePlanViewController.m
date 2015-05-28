//
//  TimePlanViewController.m
//  YIJIa
//
//  Created by sven on 3/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "TimePlanViewController.h"
#import "ComMacros.h"
#import "TouchPropagatedScrollView.h"
#import "CustomCollectionView.h"
#import "HttpRequest.h"
#import "httpConfigure.h"
#import "Util.h"

#define MENU_HEIGHT 40
#define MENU_BUTTON_WIDTH  40

#define MIN_MENU_FONT  13.f
#define MAX_MENU_FONT  16.f

@interface TimePlanViewController ()<UIScrollViewDelegate>
{
    HttpRequest *requestHttp;
    TouchPropagatedScrollView *_navScrollV;
    UIScrollView *_scrollV;
    NSMutableDictionary *_mutDicWeek;
    NSMutableDictionary *_mutDicWeekForService;
    NSMutableDictionary *_mutDicDate;
    BOOL bIsChangeWork;
    UIView *_switchView;
    UIButton *btnSelectAll;
    UIButton *btnUnSelectAll;
}

@end

@implementation TimePlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    bIsChangeWork = NO;
    [self sendRequest];
}

- (void)sendRequest
{
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *strTechNO = [defaultUser objectForKey:kTech_Number];
    NSDictionary *dic = @{@"techNumber":strTechNO};
    [[HttpRequest sharedHttpRequest] postUrl:kTechTimeURL withParam:dic didFinishBlock:^(NSString *strFeedback) {
        NSData * data = [strFeedback dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if ([dic[@"success"] boolValue]) {
            NSArray *arrServiceTimes = dic[@"list"][0];
            NSMutableArray *arrayService0 = [NSMutableArray array];
            NSMutableArray *arrayService1 = [NSMutableArray array];
            NSMutableArray *arrayService2 = [NSMutableArray array];
            NSMutableArray *arrayService3 = [NSMutableArray array];
            NSMutableArray *arrayService4 = [NSMutableArray array];
            NSMutableArray *arrayService5 = [NSMutableArray array];
            NSMutableArray *arrayService6 = [NSMutableArray array];
            for (int j = 0; j < arrServiceTimes.count; j++) {
                NSDictionary *dicService = arrServiceTimes[j];
                NSString *strServiceTime = [Util countTimeFromTimeCount:[dicService[@"SUBSCRIBE_TIME"] doubleValue]];
                NSString *strCmpareTime = [[Util timeStringFromTimeCount:[dicService[@"SUBSCRIBE_TIME"] doubleValue]] substringToIndex:10];
                int timeLength = [dicService[@"LENGTH"] intValue];
                int nCount = 0;
                if (timeLength%30 != 0) {
                    nCount = timeLength/30 + 1;
                }else{
                    nCount = timeLength/30;
                }
                
                NSString *strTime = [strServiceTime substringToIndex:11];
                NSInteger week = [Util weekFromDateString:strTime];
                
                for (int m = 1; m <= nCount; m++) {
                    NSString *strServiceTimeBefore = [Util newDateFromLastDate:strServiceTime nCount:-m*30*60];
                    NSString *strServiceTimeBeforeSub = [strServiceTimeBefore substringFromIndex:11];
                    if (week == SUN) {
                        if (![strServiceTimeBefore hasPrefix:strCmpareTime] || [arrayService0 containsObject:strServiceTimeBeforeSub]) {
                            continue;
                        }
                        [arrayService0 addObject:strServiceTimeBeforeSub];
                    }else if (week == MON){
                        if (![strServiceTimeBefore hasPrefix:strCmpareTime] || [arrayService1 containsObject:strServiceTimeBeforeSub]) {
                            continue;
                        }
                        [arrayService1 addObject:strServiceTimeBeforeSub];
                    }else if (week == TUES){
                        if (![strServiceTimeBefore hasPrefix:strCmpareTime] || [arrayService2 containsObject:strServiceTimeBeforeSub]) {
                            continue;
                        }
                        [arrayService2 addObject:strServiceTimeBeforeSub];
                    }else if (week == WED){
                        if (![strServiceTimeBefore hasPrefix:strCmpareTime] || [arrayService3 containsObject:strServiceTimeBeforeSub]) {
                            continue;
                        }
                        [arrayService3 addObject:strServiceTimeBeforeSub];
                    }else if (week == THUR){
                        if (![strServiceTimeBefore hasPrefix:strCmpareTime] || [arrayService4 containsObject:strServiceTimeBeforeSub]) {
                            continue;
                        }
                        [arrayService4 addObject:strServiceTimeBeforeSub];
                    }else if (week == FRI){
                        if (![strServiceTimeBefore hasPrefix:strCmpareTime] || [arrayService5 containsObject:strServiceTimeBeforeSub]) {
                            continue;
                        }
                        [arrayService5 addObject:strServiceTimeBeforeSub];
                    }else if (week == SAT){
                        if (![strServiceTimeBefore hasPrefix:strCmpareTime] || [arrayService6 containsObject:strServiceTimeBeforeSub]) {
                            continue;
                        }
                        [arrayService6 addObject:strServiceTimeBeforeSub];
                    }
                }
                for (int n = 0; n < 2*nCount; n++) {
                    NSString *strServiceTimeAfter = [Util newDateFromLastDate:strServiceTime nCount:n*30*60];
                    NSString *strServiceTimeAfterSub = [strServiceTimeAfter substringFromIndex:11];
                    if (week == SUN) {
                        if (![strServiceTimeAfter hasPrefix:strCmpareTime] || [arrayService0 containsObject:strServiceTimeAfterSub]) {
                            continue;
                        }
                        [arrayService0 addObject:strServiceTimeAfterSub];
                    }else if (week == MON){
                        if (![strServiceTimeAfter hasPrefix:strCmpareTime] || [arrayService1 containsObject:strServiceTimeAfterSub]) {
                            continue;
                        }
                        [arrayService1 addObject:strServiceTimeAfterSub];
                    }else if (week == TUES){
                        if (![strServiceTimeAfter hasPrefix:strCmpareTime] || [arrayService2 containsObject:strServiceTimeAfterSub]) {
                            continue;
                        }
                        [arrayService2 addObject:strServiceTimeAfterSub];
                    }else if (week == WED){
                        if (![strServiceTimeAfter hasPrefix:strCmpareTime] || [arrayService3 containsObject:strServiceTimeAfterSub]) {
                            continue;
                        }
                        [arrayService3 addObject:strServiceTimeAfterSub];
                    }else if (week == THUR){
                        if (![strServiceTimeAfter hasPrefix:strCmpareTime] || [arrayService4 containsObject:strServiceTimeAfterSub]) {
                            continue;
                        }
                        [arrayService4 addObject:strServiceTimeAfterSub];
                    }else if (week == FRI){
                        if (![strServiceTimeAfter hasPrefix:strCmpareTime] || [arrayService5 containsObject:strServiceTimeAfterSub]) {
                            continue;
                        }
                        [arrayService5 addObject:strServiceTimeAfterSub];
                    }else if (week == SAT){
                        if (![strServiceTimeAfter hasPrefix:strCmpareTime] || [arrayService6 containsObject:strServiceTimeAfterSub]) {
                            continue;
                        }
                        [arrayService6 addObject:strServiceTimeAfterSub];
                    }
                }
                
            }
            
            _mutDicWeekForService = [NSMutableDictionary dictionary];
            [_mutDicWeekForService setObject:arrayService0 forKey:[NSString stringWithFormat:@"%d", SUN]];
            [_mutDicWeekForService setObject:arrayService1 forKey:[NSString stringWithFormat:@"%d", MON]];
            [_mutDicWeekForService setObject:arrayService2 forKey:[NSString stringWithFormat:@"%d", TUES]];
            [_mutDicWeekForService setObject:arrayService3 forKey:[NSString stringWithFormat:@"%d", WED]];
            [_mutDicWeekForService setObject:arrayService4 forKey:[NSString stringWithFormat:@"%d", THUR]];
            [_mutDicWeekForService setObject:arrayService5 forKey:[NSString stringWithFormat:@"%d", FRI]];
            [_mutDicWeekForService setObject:arrayService6 forKey:[NSString stringWithFormat:@"%d", SAT]];
            
            NSArray *arrDatas = dic[@"list"][1];
            NSMutableArray *array0 = [NSMutableArray array];
            NSMutableArray *array1 = [NSMutableArray array];
            NSMutableArray *array2 = [NSMutableArray array];
            NSMutableArray *array3 = [NSMutableArray array];
            NSMutableArray *array4 = [NSMutableArray array];
            NSMutableArray *array5 = [NSMutableArray array];
            NSMutableArray *array6 = [NSMutableArray array];
            for (int i = 0; i < arrDatas.count; i++) {
                NSString *strDateString = arrDatas[i][@"REST_TIME"];
                NSString *strTime = [strDateString substringToIndex:10];
                NSString *strTimeSub = [strDateString substringFromIndex:11];
                NSInteger week = [Util weekFromDateString:strTime];
                
                if (week == SUN) {
                    [array0 addObject:strTimeSub];
                }else if (week == MON){
                    [array1 addObject:strTimeSub];
                }else if (week == TUES){
                    [array2 addObject:strTimeSub];
                }else if (week == WED){
                    [array3 addObject:strTimeSub];
                }else if (week == THUR){
                    [array4 addObject:strTimeSub];
                }else if (week == FRI){
                    [array5 addObject:strTimeSub];
                }else if (week == SAT){
                    [array6 addObject:strTimeSub];
                }
            }
            
            _mutDicWeek = [NSMutableDictionary dictionary];
            [_mutDicWeek setObject:array0 forKey:[NSString stringWithFormat:@"%d", SUN]];
            [_mutDicWeek setObject:array1 forKey:[NSString stringWithFormat:@"%d", MON]];
            [_mutDicWeek setObject:array2 forKey:[NSString stringWithFormat:@"%d", TUES]];
            [_mutDicWeek setObject:array3 forKey:[NSString stringWithFormat:@"%d", WED]];
            [_mutDicWeek setObject:array4 forKey:[NSString stringWithFormat:@"%d", THUR]];
            [_mutDicWeek setObject:array5 forKey:[NSString stringWithFormat:@"%d", FRI]];
            [_mutDicWeek setObject:array6 forKey:[NSString stringWithFormat:@"%d", SAT]];
            
            [self customSelfUI];
        }
    } didFailedBlock:^(NSString *strFeedback) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)customSelfUI
{
    self.title = @"时间表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"修改排班" style:UIBarButtonItemStylePlain target:self action:@selector(handleChangeWork)];
    
    _navScrollV = [[TouchPropagatedScrollView alloc] initWithFrame:CGRectMake(0, 5, APP_Frame_Width, 44)];
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    NSArray *arrWeek = [Util obtainOneWeekDaysFromNow];
    NSArray *arrDays = [Util judgeOneWeekDayFromNow];
    _mutDicDate = [NSMutableDictionary dictionary];
    for (int i = 0; i < arrWeek.count; i++) {
        [_mutDicDate setObject:[arrDays[i] substringToIndex:10] forKey:[NSString stringWithFormat:@"%d", ([arrWeek[i] integerValue])]];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake((MENU_BUTTON_WIDTH+13) * i+4, 0, MENU_BUTTON_WIDTH, MENU_HEIGHT)];
        NSString *strImage = [NSString stringWithFormat:@"周%d_灰色", ([arrWeek[i] integerValue]-1)];
        [btn setBackgroundImage:PNGIMAGE(strImage) forState:UIControlStateNormal];
        NSString *strTitle = [NSString stringWithFormat:@"%@.%@", [arrDays[i] substringWithRange:NSMakeRange(5, 2)], [arrDays[i] substringWithRange:NSMakeRange(8, 2)]];
        [btn setTitle:strTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(15.0, 2, 2, 2)];
        btn.tag = i + 1;
        if (i == 0) {
            [self changeColorForButton:btn red:1];
        }else{
            [self changeColorForButton:btn red:0];
        }
        [btn addTarget:self action:@selector(actionbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navScrollV addSubview:btn];
    }
    [_navScrollV setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * 6, MENU_HEIGHT)];
    [self.view addSubview:_navScrollV];
    
    _switchView = [[UIView alloc] initWithFrame:_navScrollV.frame];
    _switchView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_switchView];
    _switchView.hidden = YES;
    btnSelectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSelectAll setFrame:CGRectMake((APP_Frame_Width-100*2)/2, 10, 100, 30)];
    [btnSelectAll setTitle:@"全选" forState:UIControlStateNormal];
    [btnSelectAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSelectAll setTitleColor:[UIColor colorWithRed:249/255.0f green:127/255.0f blue:164/255.0f alpha:1.0] forState:UIControlStateSelected];
    [btnSelectAll setBackgroundColor:[UIColor lightGrayColor]];
    [btnSelectAll addTarget:self action:@selector(handleSelectAll) forControlEvents:UIControlEventTouchUpInside];
    
    btnUnSelectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnUnSelectAll setFrame:CGRectMake((APP_Frame_Width-100*2)/2+100+1, 10, 100, 30)];
    [btnUnSelectAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnUnSelectAll setTitleColor:[UIColor colorWithRed:249/255.0f green:127/255.0f blue:164/255.0f alpha:1.0] forState:UIControlStateSelected];
    [btnUnSelectAll setTitle:@"全不选" forState:UIControlStateNormal];
    [btnUnSelectAll setBackgroundColor:[UIColor lightGrayColor]];
    [btnUnSelectAll addTarget:self action:@selector(handleUnSelectAll) forControlEvents:UIControlEventTouchUpInside];
    [_switchView addSubview:btnSelectAll];
    [_switchView addSubview:btnUnSelectAll];
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navScrollV.frame), APP_Frame_Width, APP_Frame_Height_Use)];
    [_scrollV setPagingEnabled:YES];
    [_scrollV setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollV];
    _scrollV.delegate = self;
    [_scrollV.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    _scrollV.backgroundColor = [UIColor colorWithRed:243/255.0f green:242/255.0f blue:240/255.0f alpha:1.0];
    
    NSArray *arT = [Util obtainOneWeekDaysFromNow];
    [self addView2Page:_scrollV array:arT];
}

- (void)addView2Page:(UIScrollView *)scrollV array:(NSArray *)arr
{
    for (int i = 0; i < [arr count]; i++)
    {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        NSString *strKey = [NSString stringWithFormat:@"%d", [arr[i] integerValue]];
        NSMutableArray *mutArr = _mutDicWeek[strKey];
        NSMutableArray *mutServiceArr = _mutDicWeekForService[strKey];
        NSString *strDate = _mutDicDate[strKey];
        CustomCollectionView *view = [[CustomCollectionView alloc] initWithFrame:CGRectMake(scrollV.frame.size.width * i, 0, scrollV.frame.size.width, scrollV.frame.size.height) collectionViewLayout:flowLayout array:mutArr servicesArr:mutServiceArr dateString:strDate];
        view.autoresizesSubviews = YES;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.tag = i+1;
        [scrollV addSubview:view];  
        
    }
    [scrollV setContentSize:CGSizeMake(scrollV.frame.size.width * [arr count], scrollV.frame.size.height)];
}

- (void)changeColorForButton:(UIButton *)btn red:(float)nRedPercent
{
    if (btn)
    {
        NSArray *arrWeek = [Util obtainOneWeekDaysFromNow];
        if (nRedPercent == 1) {
            NSString *strImage = [NSString stringWithFormat:@"周%d_红色", ([arrWeek[btn.tag-1] integerValue]-1)];
            [btn setBackgroundImage:PNGIMAGE(strImage) forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            NSString *strImage = [NSString stringWithFormat:@"周%d_灰色", ([arrWeek[btn.tag-1] integerValue]-1)];
            [btn setBackgroundImage:PNGIMAGE(strImage) forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
}

- (void)actionbtn:(UIButton *)btn
{
    [_scrollV scrollRectToVisible:CGRectMake(_scrollV.frame.size.width * (btn.tag - 1), _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height) animated:YES];
    
    float xx = _scrollV.frame.size.width * (btn.tag - 1) * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}

-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    BOOL isPaning = NO;
    if(_scrollV.contentOffset.x < 0)
    {
        isPaning = YES;
        //        isLeftDragging = YES;
        //        [self showMask];
    }
    else if(_scrollV.contentOffset.x > (_scrollV.contentSize.width - _scrollV.frame.size.width))
    {
        isPaning = YES;
        //        isRightDragging = YES;
        //        [self showMask];
    }
    if(isPaning)
    {
        //        [[QHSliderViewController sharedSliderController] moveViewWithGesture:panParam];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //        _startPointX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeView:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float xx = scrollView.contentOffset.x * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}

- (float)lerp:(float)percent min:(float)nMin max:(float)nMax
{
    float result = nMin;
    
    result = nMin + percent * (nMax - nMin);
    
    return result;
}

- (void)changeView:(float)x
{
    
    float xx = x * (MENU_BUTTON_WIDTH / self.view.frame.size.width);
    
    float startX = xx;
    //    float endX = xx + MENU_BUTTON_WIDTH;
    int sT = (x)/_scrollV.frame.size.width + 1;
    
    if (sT <= 0)
    {
        return;
    }
    UIButton *btn = (UIButton *)[_navScrollV viewWithTag:sT];
    float percent = (startX - MENU_BUTTON_WIDTH * (sT - 1))/MENU_BUTTON_WIDTH;
    [self changeColorForButton:btn red:(1 - percent)];
    
    if((int)xx%MENU_BUTTON_WIDTH == 0)
        return;
    UIButton *btn2 = (UIButton *)[_navScrollV viewWithTag:sT + 1];
    [self changeColorForButton:btn2 red:percent];
}

- (void)handleSelectAll
{
    btnSelectAll.selected = YES;
    btnUnSelectAll.selected = NO;
    int tag = _scrollV.contentOffset.x/APP_Frame_Width+1;
    CustomCollectionView *subView = (CustomCollectionView *)[_scrollV viewWithTag:tag];
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:@[ @"8:30", @"9:00", @"9:30", @"10:00", @"10:30", @"11:00",
                                                        @"11:30", @"12:00", @"12:30", @"13:00", @"13:30", @"14:00",
                                                        @"14:30", @"15:00", @"15:30", @"16:00", @"16:30", @"17:00",
                                                        @"17:30", @"18:00", @"18:30", @"19:00", @"19:30", @"20:00",
                                                        @"20:30", @"21:00", @"21:30", @"22:00"]];
    [mutArr removeObjectsInArray:subView.arrServiceData];
    subView.arrData = mutArr;
    [subView reloadData];
}

- (void)handleUnSelectAll
{
    btnSelectAll.selected = NO;
    btnUnSelectAll.selected = YES;
    
    int tag = _scrollV.contentOffset.x/APP_Frame_Width+1;
    CustomCollectionView *subView = (CustomCollectionView *)[_scrollV viewWithTag:tag];
    subView.arrData = [NSMutableArray array];
    [subView reloadData];
}

- (void)handleChangeWork
{
    int tag = _scrollV.contentOffset.x/APP_Frame_Width+1;
    CustomCollectionView *subView = (CustomCollectionView *)[_scrollV viewWithTag:tag];
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"修改排班"]) {
        bIsChangeWork = YES;
        self.navigationItem.rightBarButtonItem.title = @"保存";
    }else{
        bIsChangeWork = NO;
        self.navigationItem.rightBarButtonItem.title = @"修改排班";
        
        [self saveTimeArange:subView.arrData date:subView.strDate];
    }
    subView.bIsChanging = bIsChangeWork;
    
    [UIView animateWithDuration:0.3f animations:^{
        if (bIsChangeWork) {
            _navScrollV.hidden = YES;
            _switchView.hidden = NO;
//            _scrollV.frame = CGRectMake(0, 0, APP_Frame_Width, APP_Frame_Height_Use+CGRectGetHeight(_navScrollV.frame));
            _scrollV.scrollEnabled = NO;
        }else{
            _navScrollV.hidden = NO;
            _switchView.hidden = YES;
//            _scrollV.frame = CGRectMake(0, CGRectGetMaxY(_navScrollV.frame), APP_Frame_Width, APP_Frame_Height_Use);
            _scrollV.scrollEnabled = YES;
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)saveTimeArange:(NSMutableArray *)mutArr date:(NSString *)strDate
{
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *strUserNO = [defaultUser objectForKey:kTech_Number];
    
    NSMutableString *mutStrDateTime = [NSMutableString string];
    for (int i = 0; i < mutArr.count; i++) {
        NSString *strSub = [NSString stringWithFormat:@"%@ %@,", strDate, mutArr[i]];
        [mutStrDateTime appendString:strSub];
    }
    if (mutStrDateTime.length > 1) {
        [mutStrDateTime replaceCharactersInRange:NSMakeRange(mutStrDateTime.length-1, 1) withString:@""];
    }else {
        [mutStrDateTime appendString:@""];
    }
    
    NSString *strReturnDateTime = [mutStrDateTime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"techNumber":strUserNO, @"date":strDate, @"dateTime":strReturnDateTime};
    [[HttpRequest sharedHttpRequest] postUrl:kModefyTechURL withParam:dic didFinishBlock:^(NSString *strFeedback) {
        {
            NSLog(@"strFeedBack:%@", strFeedback);
        }
    } didFailedBlock:^(NSString *strFeedback) {
        {
        }
    }];
}

@end
