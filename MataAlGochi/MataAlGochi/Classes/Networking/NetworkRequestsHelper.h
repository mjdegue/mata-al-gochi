//
//  NetworkRequestsHelper.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/26/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gochi.h"

#define NWNOTIFICATION_GOCHI_LOADED_SUCCED @"GOCHI_LOADED_NOTIFICATION_SUCCED"
#define NWNOTIFICATION_GOCHI_LOADED_FAILURE @"GOCHI_LOADED_NOTIFICATION_FAILURE"

#define OWN_GOCHI_ID @"MD_7693"

typedef void (^SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface NetworkRequestsHelper : NSObject

-(void)postGochiOnServer:(Gochi*) gochi;
-(void)postGochiOnServer:(Gochi*) gochi successBlock:(SuccessBlock) success failureBlock:(FailureBlock) failure;

-(void) getOwnGochiFromServer;

+(instancetype) sharedInstance;
@end
