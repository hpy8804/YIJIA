//
//  ComMacros.h
//  YIJIa
//
//  Created by sven on 3/19/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#ifndef YIJIa_Header_h
#define YIJIa_Header_h
/*
 ************************* app相关(frame and postion) *************************
 **/

#pragma mark - Frame

//App Frame
#define Application_Frame [[UIScreen mainScreen] applicationFrame]

//App Frame Height&Width
#define APP_Frame_Height ([[UIScreen mainScreen] applicationFrame].size.height)
#define APP_Frame_Width  ([[UIScreen mainScreen] applicationFrame].size.width)
#define APP_Frame_Height_Use ([[UIScreen mainScreen] applicationFrame].size.height-44-49)

//talbeView Cell height
#define APP_TableView_Cell_Height (iPhone5?55:44)



/*
 *************************** Function Method ***************************
 **/
#pragma mark - Function Method

// 加载图片
#define PNGIMAGE(NAME)   [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]

//是否iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//ios系统版本
#define IOS6 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 6.0)
#define IOS7 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)

//国际化
#define Localized(s) NSLocalizedString(s,s)

//app delegate
#define App_Delegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#endif
