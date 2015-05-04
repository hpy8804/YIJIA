//
//  HttpRequest.m
//  YIJIa
//
//  Created by sven on 3/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//
#import "HttpRequest.h"
#import "HUD.h"
@interface HttpRequest()
{
    NSMutableData *_mutRecvData;
}
@end

@implementation HttpRequest

singleton_implementation(HttpRequest)

- (void)postUrl:(NSString *)strURL withParam:(NSDictionary *)dicParam didFinishBlock:(BlockHttpRespond)finishBlock didFailedBlock:(BlockHttpRespond)failedBlock
{
    _finishBlock = finishBlock;
    _errorBlock = failedBlock;
    
    NSMutableString *mutBodyString = [NSMutableString string];
    [mutBodyString appendString:@"?"];
    for (NSString *strKey in [dicParam allKeys]) {
        NSString *subString = [NSString stringWithFormat:@"%@=%@", strKey, dicParam[strKey]];
        [mutBodyString appendString:subString];
        [mutBodyString appendString:@"&"];
    }
    [mutBodyString replaceCharactersInRange:NSMakeRange(mutBodyString.length-1, 1) withString:@""];
    
    NSURL *postURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", strURL, mutBodyString]];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:postURL];
    
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    [HUD showUIBlockingIndicatorWithText:@"请稍候..."];
    if (connect) {
        _mutRecvData = [NSMutableData data];
    }
}

#pragma mark NSURLConnection delegate
-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    [_mutRecvData setLength:0];
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    [_mutRecvData appendData:data];
}

-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    NSString *strResult = [[NSString alloc] initWithData:_mutRecvData encoding:NSUTF8StringEncoding];
    [HUD hideUIBlockingIndicator];
    _finishBlock(strResult);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *strError = [error localizedFailureReason];
    [HUD hideUIBlockingIndicator];
    _errorBlock(strError);
}
@end
