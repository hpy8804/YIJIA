//
//  AddCommentViewController.h
//  YIJIa
//
//  Created by sven on 5/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "BaseViewController.h"

@interface AddCommentViewController : BaseViewController
@property (strong, nonatomic) NSString *order_id;
@property (weak, nonatomic) IBOutlet UITextView *addComment;

@end
