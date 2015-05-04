//
//  HttpRequest.h
//  YIJIa
//
//  Created by sven on 3/20/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
typedef void (^BlockHttpRespond)(NSString *strFeedback);
@interface HttpRequest : NSObject
{
    BlockHttpRespond _finishBlock;
    BlockHttpRespond _errorBlock;
}

singleton_interface(HttpRequest)

- (void)postUrl:(NSString *)strURL withParam:(NSDictionary *)dicParam didFinishBlock:(BlockHttpRespond)finishBlock didFailedBlock:(BlockHttpRespond)failedBlock;
@end
