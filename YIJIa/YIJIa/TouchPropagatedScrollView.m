//
//  TouchPropagatedScrollView.m
//  iMoreCam
//
//  Created by sven on 10/22/14.
//  Copyright (c) 2014 sven@abovelink. All rights reserved.
//

#import "TouchPropagatedScrollView.h"

@implementation TouchPropagatedScrollView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}

@end
