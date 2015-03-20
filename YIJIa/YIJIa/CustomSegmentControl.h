//
//  CustomSegmentControl.h
//  iMoreCam
//
//  Created by sven on 11/7/14.
//  Copyright (c) 2014 sven@abovelink. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Button_tag_orderTime = 201,
    Button_tag_dateTime
} Button_tag;

@interface CustomSegmentControl : UIView
@property (nonatomic, copy) void (^handleSwitchSegment)(UIButton *btn);

- (void)setSelectedIndex:(int)index;
@end
