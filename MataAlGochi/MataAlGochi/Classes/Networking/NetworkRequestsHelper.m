//
//  NetworkRequestsHelper.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/26/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "NetworkRequestsHelper.h"
#import "NetworkManager.h"

#define OWN_GOCHI_ID @"MD_7693"
#define POST_EVENT_PATH @"pet"
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
    NSDictionary* parameters = [self dictionaryByGochi:gochi];
    
    [[NetworkManager sharedInstance] POST:POST_EVENT_PATH parameters:parameters
                                 success:(success != nil) ? success : [self genericSuccedBlock]
                                 failure:(failure != nil) ? failure : [self genericFailureBlock]];
}



#pragma mark - Get own gochi from server

-(void) getOwnGochiFromServer
{
    
    SuccessBlock success = ^(NSURLSessionDataTask* task, id responseObject)
    {
        Gochi* gochi = [[Gochi alloc] initWithDictionary:(NSDictionary*)responseObject];
        [[NSNotificationCenter defaultCenter] postNotificationName:NWNOTIFICATION_GOCHI_LOADED_SUCCED object:gochi];
    };
    
    FailureBlock failure = ^(NSURLSessionDataTask* task, NSError* error)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NWNOTIFICATION_GOCHI_LOADED_FAILURE object:nil];
    };

    NSString* getUrlString = [NSString stringWithFormat:SPECIFIC_PET_GET, OWN_GOCHI_ID];
    
    [[NetworkManager sharedInstance] GET:getUrlString parameters:nil success:success failure:failure];
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

#pragma mark - Generic Gochi Methods

- (NSDictionary*) dictionaryByGochi:(Gochi*) gochi
{
    NSMutableDictionary* answer = [[NSMutableDictionary alloc] init];
    answer[@"code"] = OWN_GOCHI_ID;
    answer[@"name"] = gochi.name;
    answer[@"energy"] = gochi.energy;
    answer[@"level"] = gochi.level;
    answer[@"experience"] = gochi.experience;
    return answer;
}


//Private methods
- (SuccessBlock) genericSuccedBlock
{
    SuccessBlock block =^(NSURLSessionDataTask* task, id responseObject)
    {
        NSLog(@"Auto success block OK!");
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
