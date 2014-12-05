//
//  ServerTest.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/5/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Gochi.h"
#import "NetworkRequestsHelper.h"
@interface ServerTest : XCTestCase

@end

@implementation ServerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - MockGochis
- (NSDictionary*) dictionaryForGochiWithEnergy:(NSNumber*)energy experience:(NSNumber*) expe code:(NSString*) code
{
    NSMutableDictionary* answer = [[NSMutableDictionary alloc] init];
    answer[@"code"] = code;
    answer[@"name"] = @"HardcodedGochi";
    answer[@"energy"] = energy;
    answer[@"level"] = [NSNumber numberWithInt:1];
    answer[@"experience"] = expe;
    answer[@"pet_type"] = [[NSNumber alloc] initWithInt:PET_CAT];
    return answer;
}

- (Gochi*) mockGochiForPost
{
    Gochi* gochi = [[Gochi alloc]initWithDictionary:[self dictionaryForGochiWithEnergy:[NSNumber numberWithInt:50] experience:[NSNumber numberWithInt:0] code:@"MD_7693"]];
    return gochi;
}

- (void) test01PostPet
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testPostPet"];
    SuccessBlock success = ^(NSURLSessionDataTask* task, id responseObject)
    {
        [expectation fulfill];
    };
    FailureBlock failure = ^(NSURLSessionDataTask* task, NSError* error)
    {
        XCTFail(@"Error ocurred: %@", [error localizedDescription]);
    };
    
    [[NetworkRequestsHelper sharedInstance] postGochiOnServer:[self mockGochiForPost] successBlock:success failureBlock:failure];
    
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError *error)
     {
         if(error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
         }
         XCTFail(@"Error, post went in timeout");
     }];
    
}

- (void) test02RetrieveOneGochiFromServer
{
    Gochi* gochiToCompare = [self mockGochiForPost];
    XCTestExpectation *expectation = [self expectationWithDescription:@"testPostPet"];
    SuccessBlock success = ^(NSURLSessionDataTask* task, id responseObject)
    {
        Gochi* responseGochi = [[Gochi alloc] initWithDictionary:responseObject];
        
        if(![[gochiToCompare code] isEqualToString:[responseGochi code]] ||
            [[gochiToCompare level] isEqualToValue:[responseGochi level]] ||
            [[gochiToCompare energy] isEqualToValue:[responseGochi energy]])
        {
            XCTFail(@"Response object gochi is different");
        }
        
        [expectation fulfill];
    };
    FailureBlock failure = ^(NSURLSessionDataTask* task, NSError* error)
    {
        XCTFail(@"Error ocurred: %@", [error localizedDescription]);
    };
    
    [[NetworkRequestsHelper sharedInstance] getGochiFromServerByCode:[gochiToCompare code] success:success failure:failure];
    
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError *error)
     {
         if(error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
         }
         XCTFail(@"Error, get went in timeout");
     }];
}

- (void) test03RetreiveAllGochisFromServer
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"testPostPet"];
    SuccessBlock success = ^(NSURLSessionDataTask* task, id responseObject)
    {
        NSArray* responseArray = responseObject;
        
        if([responseArray count] == 0)
        {
            XCTFail(@"There came no gochis from server");
        }
        [expectation fulfill];
        
    };
    FailureBlock failure = ^(NSURLSessionDataTask* task, NSError* error)
    {
        XCTFail(@"Error ocurred: %@", [error localizedDescription]);
    };
    
    [[NetworkRequestsHelper sharedInstance] retreiveAllGochisFromServerWithSuccess:success failure:failure];
    
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError *error)
     {
         if(error)
         {
             NSLog(@"Error: %@", [error localizedDescription]);
         }
         XCTFail(@"Error, get went in timeout");
     }];
}


@end
