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
    NSMutableDictionary *_mutDicDate;
    BOOL bIsChangeWork;
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
    for (int i = 0; i < arrWeek.count; i++) {
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
        CustomCollectionView *view = [[CustomCollectionView alloc] initWithFrame:CGRectMake(scrollV.frame.size.width * i, 0, scrollV.frame.size.width, scrollV.frame.size.height) collectionViewLayout:flowLayout array:mutArr];
        view.autoresizesSubviews = YES;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        view.tag = i+1;
        [scrollV addSubview:view];  
        
    }
    [scrollV setContentSize:CGSizeMake(scrollV.frame.size.width * [arr count], scrollV.frame.size.height)];
}

- (void)changeColorForButton:(UIButton *)btn red:(float)nRedPercent
{
    if (nRedPercent == 1) {
        NSString *strImage = [NSString stringWithFormat:@"周%d_红色", btn.tag+1];
        [btn setBackgroundImage:PNGIMAGE(strImage) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
        NSString *strImage = [NSString stringWithFormat:@"周%d_灰色", btn.tag+1];
        [btn setBackgroundImage:PNGIMAGE(strImage) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
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
        
        [self saveTimeArange:subView.arrData week:tag];
    }
    subView.bIsChanging = bIsChangeWork;
    
    [UIView animateWithDuration:0.3f animations:^{
        if (bIsChangeWork) {
            _navScrollV.hidden = YES;
            _scrollV.frame = CGRectMake(0, 0, APP_Frame_Width, APP_Frame_Height_Use+CGRectGetHeight(_navScrollV.frame));
            _scrollV.scrollEnabled = NO;
        }else{
            _navScrollV.hidden = NO;
            _scrollV.frame = CGRectMake(0, CGRectGetMaxY(_navScrollV.frame), APP_Frame_Width, APP_Frame_Height_Use);
            _scrollV.scrollEnabled = YES;
        }
    } completion:^(BOOL finished) {
        
    }];
}

- (void)saveTimeArange:(NSMutableArray *)mutArr week:(NSInteger)week
{
    NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
    NSString *strUserName = [defaultUser objectForKey:kUserName];
    
//    kModefyTechURL
}

@end
