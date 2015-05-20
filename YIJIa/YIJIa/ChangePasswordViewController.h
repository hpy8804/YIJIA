//
//  ChangePasswordViewController.h
//  YIJIa
//
//  Created by sven on 5/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *passwordOld;
@property (weak, nonatomic) IBOutlet UITextField *passwordNew;
@property (weak, nonatomic) IBOutlet UITextField *passwordSure;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;


@end
