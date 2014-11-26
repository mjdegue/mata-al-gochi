//
//  NetworkTestClass.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/26/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "NetworkTestClass.h"
#import "NetworkManager.h"

typedef void (^SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, NSError *error)   ;

@implementation NetworkTestClass

- (void) callMethod
{
    SuccessBlock succBlock = ^(NSURLSessionDataTask* task, id responseObject) {
        NSLog(@"Loggin success!!");
    };
    FailureBlock failBlock =^(NSURLSessionDataTask* task, id responseObject) {
        NSLog(@"Loggin Failure!!!");
    };
    [[NetworkManager sharedInstance] GET:nil parameters:nil
                                 success:succBlock failure:failBlock];
}
@end
