//
//  NetworkRequestsHelper.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/26/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "NetworkRequestsHelper.h"
#import "NetworkManager.h"

#define POST_EVENT_PATH @"pet"
#define ALL_PETS_GET @"pet/all"
#define SPECIFIC_PET_GET @"pet/%@"

@implementation NetworkRequestsHelper


#pragma mark - Post Gochi on server

-(void)postGochiOnServer:(Gochi*) gochi
{
    [self postGochiOnServer:gochi
               successBlock:[self genericSuccedBlock]
               failureBlock:[self genericFailureBlock]];
}

-(void)postGochiOnServer:(Gochi*) gochi successBlock:(SuccessBlock) success failureBlock:(FailureBlock) failure
{
    NSDictionary* parameters = [gochi dictionaryByGochi];
    
    [[NetworkManager sharedInstance] POST:POST_EVENT_PATH parameters:parameters
                                 success:(success != nil) ? success : [self genericSuccedBlock]
                                 failure:(failure != nil) ? failure : [self genericFailureBlock]];
}

#pragma mark - Get own gochi from server

-(void) getOwnGochiFromServer
{
    [self getGochiFromServerByCode:OWN_GOCHI_ID];
}

-(void) getGochiFromServerByCode:(NSString *)code success:(SuccessBlock)success failure:(FailureBlock)failure
{
    NSString* getUrlString = [NSString stringWithFormat:SPECIFIC_PET_GET, code];
    
    [[NetworkManager sharedInstance] GET:getUrlString parameters:nil success:success failure:failure];
}

-(void) getGochiFromServerByCode:(NSString *)code
{
    
    SuccessBlock success = ^(NSURLSessionDataTask* task, id responseObject)
    {
        Gochi* gochi = [[Gochi alloc] initWithDictionary:responseObject];
        [[NSNotificationCenter defaultCenter] postNotificationName:NWNOTIFICATION_GOCHI_LOADED_SUCCED object:gochi];
    };
    
    FailureBlock failure = ^(NSURLSessionDataTask* task, NSError* error)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NWNOTIFICATION_GOCHI_LOADED_FAILURE object:nil];
    };
    
    [self getGochiFromServerByCode:code success:success failure:failure];
}

-(void) retreiveAllGochisFromServerWithSuccess:(SuccessBlock) success failure:(FailureBlock) failure
{
    [[NetworkManager sharedInstance] GET:ALL_PETS_GET parameters:nil success:success failure:failure];
}

-(void) retreiveAllGochisFromServer
{
    
    SuccessBlock success = ^(NSURLSessionDataTask* task, id responseObject)
    {
        NSMutableArray* gochisList = [[NSMutableArray alloc] init];
        for(NSDictionary* petDic in responseObject)
        {
            Gochi* gochi = [[Gochi alloc] initWithDictionary:petDic];
            [gochisList addObject:gochi];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:NWNOTIFICATION_GOCHIS_LIST_LODED_SUCCESS object:gochisList];
    };
    FailureBlock failure = ^(NSURLSessionDataTask* task, NSError* error)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NWNOTIFICATION_GOCHIS_LIST_LODED_FAILURE object:nil];
    };
    [self retreiveAllGochisFromServerWithSuccess:success failure:failure];
    
}

#pragma mark - singleton
static NetworkRequestsHelper* instance = nil;
+ (instancetype)sharedInstance
{
    if(instance == nil)
    {
        instance = [[NetworkRequestsHelper alloc] init];
    }
    return instance;
}

#pragma mark - Generic Methods

//Private methods
- (SuccessBlock) genericSuccedBlock
{
    SuccessBlock block =^(NSURLSessionDataTask* task, id responseObject)
    {
        NSLog(@"Auto success block OK!:\n %@", responseObject);
    };
    return block;
}

- (FailureBlock) genericFailureBlock
{
    FailureBlock block =^(NSURLSessionDataTask* task, NSError* error)
    {
        NSLog(@"Log error %@", [error localizedDescription]);
    };
    return block;
}

@end
