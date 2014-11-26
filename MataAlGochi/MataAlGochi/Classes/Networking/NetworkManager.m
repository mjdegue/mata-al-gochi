//
//  NetworkManager.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/26/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//
#import "NetworkManager.h"
#import "AFNetworkActivityIndicatorManager.h"

#define REQUESTS_TIME_OUT 20
#define BASE_URL @"http://echo.jsontest.com/key/value/one/two"
@implementation NetworkManager
+ (instancetype)sharedInstance
{
    static NetworkManager *_sharedInstance = nil;
    static dispatch_once_t onceToken; dispatch_once(&onceToken, ^{
        
        // Network activity indicator manager setup
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        // Session configuration setup
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = [NetworkManager getAdditionalHeaders];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024 // 10MB. memory cache
                                                          diskCapacity:50 * 1024 * 1024 // 50MB. on disk cache
                                                              diskPath:nil];
        
        sessionConfiguration.URLCache = cache;
        sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        sessionConfiguration.timeoutIntervalForRequest = REQUESTS_TIME_OUT;
        
        // Initialize the session
        _sharedInstance = [[NetworkManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]
                                             sessionConfiguration:sessionConfiguration];
        
        //Setup a default JSONSerializer for all request/responses.
        _sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
        
    }); //ends of block
    return _sharedInstance;

}

+ (NSDictionary*) getAdditionalHeaders
{
    NSDictionary* answer = [[NSDictionary alloc] init];
    
    return answer;
}

@end