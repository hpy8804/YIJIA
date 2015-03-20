//
//  HttpRequest.h
//  YIJIa
//
//  Created by sven on 3/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpRequestDelegate <NSObject>
@optional
- (void)didFinishRequestWithString:(NSString *)strResult;
- (void)didFailedRequestWithErrorString:(NSString *)strError;
@end

@interface HttpRequest : NSObject
- (id)initWithDelegate:(id)delegate;
- (void)sendRequestWithURLString:(NSString *)strURL;
@property (assign, nonatomic) id <HttpRequestDelegate>delegate;
@end
