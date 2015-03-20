//
//  UINavigationBar+CustomBar.m
//  iMoreCam
//
//  Created by sven on 9/9/14.
//  Copyright (c) 2014 sven@abovelink. All rights reserved.
//

#import "UINavigationBar+CustomBar.h"
#import "ComMacros.h"
#import "Util.h"

#define kNav_back_color [UIColor colorWithRed:53/255.0f green:162/255.0f  blue:231/255.0f alpha:1.0f]

@implementation UINavigationBar (CustomBar)
- (void)customNavigationBar
{
    UIImage *colorImage = PNGIMAGE(@"顶栏_红色");
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        if(IOS6)
        {
            UIImage *navBarBgImg = [colorImage stretchableImageWithLeftCapWidth:7.f topCapHeight:22.f];
            [self setBackgroundImage:navBarBgImg forBarMetrics:UIBarMetricsDefault];
        }
        else
        {
            CGSize titleSize = self.bounds.size;  //获取Navigation Bar的位置和大小
            
            UIGraphicsBeginImageContext(titleSize);
            [colorImage drawInRect:CGRectMake(0, 0, titleSize.width, titleSize.height)];
            UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [self setBackgroundImage:scaledImage forBarMetrics:UIBarMetricsDefault];
        }
    }
    else
    {
        [self drawRect:self.bounds];
    }
}


- (void)drawRect:(CGRect)rect {
    UIImage *image = [Util imageWithColor:kNav_back_color];
    [image drawInRect:rect];
}

@end
