//
//  CustomCollectionView.h
//  YIJIa
//
//  Created by sven on 4/7/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.text = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, CGRectGetWidth(self.frame)-10, 20)];
        self.text.backgroundColor = [UIColor clearColor];
        self.text.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.text];
        
        self.textStatus = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.text.frame)+10, CGRectGetWidth(self.frame), 30)];
        self.textStatus.backgroundColor = [UIColor clearColor];
        self.textStatus.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textStatus];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
