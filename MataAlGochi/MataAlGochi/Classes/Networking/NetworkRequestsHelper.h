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

#define NWNOTIFICATION_GOCHIS_LIST_LODED_SUCCESS @"NWNOTIFICATION_GOCHIS_LIST_LODED_SUCCESS"
#define NWNOTIFICATION_GOCHIS_LIST_LODED_FAILURE @"NWNOTIFICATION_GOCHIS_LIST_LODED_FAILURE"

typedef void (^SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface NetworkRequestsHelper : NSObject

-(void)postGochiOnServer:(Gochi*) gochi;
-(void)postGochiOnServer:(Gochi*) gochi successBlock:(SuccessBlock) success failureBlock:(FailureBlock) failure;

-(void) getGochiFromServerByCode:(NSString*)code;
-(void) getGochiFromServerByCode:(NSString *)code success:(SuccessBlock)success failure:(FailureBlock)failure;
-(void) getOwnGochiFromServer;
-(void) retreiveAllGochisFromServerWithSuccess:(SuccessBlock) success failure:(FailureBlock) failure;
-(void) retreiveAllGochisFromServer;

+(instancetype) sharedInstance;
@end
