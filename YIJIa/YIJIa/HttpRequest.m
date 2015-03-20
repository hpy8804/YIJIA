//
//  HttpRequest.m
//  YIJIa
//
//  Created by sven on 3/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import "HttpRequest.h"

@interface HttpRequest ()<NSURLConnectionDataDelegate>
{
    NSURLConnection *_connection;
    NSMutableData *_backData;
}
@end

@implementation HttpRequest
- (id)initWithDelegate:(id)delegate
{
    if (self = [super init]) {
        self.delegate = delegate;
    }
    return self;
}
- (void)sendRequestWithURLString:(NSString *)strURL
{
    NSURL *URL = [NSURL URLWithString:[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  
}

//接受到respone,这里面包含了HTTP请求状态码和数据头信息，包括数据长度、编码格式等
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _backData = [[NSMutableData alloc]init];
}

//接受到数据时调用
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_backData appendData:data];
}

//数据接受结束时调用这个方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSString *strReturn = [[NSString alloc]initWithData:_backData encoding:NSUTF8StringEncoding];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishRequestWithString:)]) {
        [self.delegate didFinishRequestWithString:strReturn];
    }
}

//这是请求出错是调用
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSString *strError = [error localizedDescription];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFailedRequestWithErrorString:)]) {
        [self.delegate didFailedRequestWithErrorString:strError];
    }
}
@end
