//
//  Singleton.h
//  iMoreCam
//
//  Created by sven on 9/9/14.
//  Copyright (c) 2014 sven@abovelink. All rights reserved.
//

#ifndef iMoreCam_Header_h
#define iMoreCam_Header_h

#define singleton_interface(className) \
+ (className *)shared##className;

#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#endif
