//
//  CustomSegmentControl.m
//  iMoreCam
//
//  Created by sven on 11/7/14.
//  Copyright (c) 2014 sven@abovelink. All rights reserved.
//

#import "CustomSegmentControl.h"
#import "ComMacros.h"

#define kSpace 10.0f

@interface CustomSegmentControl ()
{
    UIImageView *_backImageView;
}
@end


@implementation CustomSegmentControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self customSelfUI];
    }
    return self;
}

- (void)customSelfUI
{
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSpace, kSpace, self.frame.size.width-2*kSpace, self.frame.size.height-2*kSpace)];
    _backImageView.image = PNGIMAGE(@"下单时间");
    [self addSubview:_backImageView];
    _backImageView.userInteractionEnabled = YES;
    
    UIButton *btnOrderTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOrderTime setFrame:CGRectMake(0, 0, self.frame.size.width/2, 44)];
    [btnOrderTime setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btnOrderTime.tag = Button_tag_orderTime;
    [btnOrderTime addTarget:self action:@selector(handleBtnSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:btnOrderTime];
    
    UIButton *btnDateTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDateTime setFrame:CGRectMake(CGRectGetMaxX(btnOrderTime.frame), 0, self.frame.size.width/2, 44)];
    btnDateTime.titleLabel.font = [UIFont systemFontOfSize:15.0];
    btnDateTime.tag = Button_tag_dateTime;
    [btnDateTime addTarget:self action:@selector(handleBtnSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:btnDateTime];
}

- (void)handleBtnSwitchAction:(UIButton *)sender
{
    int tag = sender.tag;
    switch (tag) {
        case Button_tag_orderTime:
        {
            _backImageView.image = PNGIMAGE(@"下单时间");
        }
            break;
        case Button_tag_dateTime:
        {
            _backImageView.image = PNGIMAGE(@"预约时间");
        }
            break;
            
        default:
            break;
    }
    
    if (_handleSwitchSegment){
        _handleSwitchSegment(sender);
    }
}


- (void)setSelectedIndex:(int)index
{
    switch (index) {
        case 0:
        {
            _backImageView.image = PNGIMAGE(@"下单时间");
        }
            break;
        case 1:
        {
            _backImageView.image = PNGIMAGE(@"预约时间");
        }
            break;
            
        default:
            break;
    }
}

@end
