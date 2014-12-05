//
//  MataAlGochiTests.m
//  MataAlGochiTests
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Gochi.h"

@interface MataAlGochiTests : XCTestCase

@end

@implementation MataAlGochiTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


//tests
#pragma mark - Dictionary Maker
- (NSDictionary*) dictionaryForGochiWithEnergy:(NSNumber*)energy experience:(NSNumber*) expe
{
    NSMutableDictionary* answer = [[NSMutableDictionary alloc] init];
    answer[@"code"] = @"MD_7693";
    answer[@"name"] = @"HardcodedGochi";
    answer[@"energy"] = energy;
    answer[@"level"] = [NSNumber numberWithInt:1];
    answer[@"experience"] = expe;
    answer[@"pet_type"] = [[NSNumber alloc] initWithInt:PET_CAT];
    return answer;
}

#pragma mark - EnergyTest
- (void)test01EnergyTest
{
    Gochi* chivoExpiatorio = [self mockGochiForEnergyTest];
    const int pastEnergy = [[chivoExpiatorio energy] intValue];
    [chivoExpiatorio update];
    const int actualEnergy = [[chivoExpiatorio energy] intValue];
    
    if((pastEnergy - actualEnergy) != 10)
    {
        XCTFail(@"Enrgy delta is diferent than what it should be");
    }
}

- (Gochi*) mockGochiForEnergyTest
{
    Gochi* gochi = [[Gochi alloc] initWithDictionary:[self dictionaryForGochiWithEnergy:[NSNumber numberWithInt:50] experience:[NSNumber numberWithInt:0]]];
    [gochi setPetState:PET_STATE_TRAINING];
    return gochi;
}


#pragma mark - ExperienceTest
- (void) test02ExperienceTest
{
    Gochi* chivoExpiatorio = [self mockGochiForExperienceTest];
    const int pastExp = [[chivoExpiatorio experience] intValue];
    [chivoExpiatorio update];
    const int actualExp = [[chivoExpiatorio experience] intValue];
    if((actualExp - pastExp) != 15)
    {
        XCTFail(@"Experience delta is diferent than what it should be");
    }
}

- (Gochi*) mockGochiForExperienceTest
{
    Gochi* gochi = [[Gochi alloc] initWithDictionary:[self dictionaryForGochiWithEnergy:[NSNumber numberWithInt:50] experience:[NSNumber numberWithInt:0]]];
    [gochi setPetState:PET_STATE_TRAINING];
    return gochi;
}

#pragma mark - LevelUpTest
- (void) test03LevelUpTest
{
    Gochi* chivoExpiatorio = [self mockGochiForLevelupTest];
    const int lastLevel = [[chivoExpiatorio level] intValue];
    [chivoExpiatorio update];
    if(([[chivoExpiatorio level] intValue] - lastLevel) != 1)
    {
        XCTFail(@"level delta is diferent than what it should");
    }
    if([[chivoExpiatorio experience] intValue] != 5)
    {
        XCTFail(@"Experience is diferent than what it should");
    }
}

- (Gochi*) mockGochiForLevelupTest
{
    Gochi* gochi = [[Gochi alloc] initWithDictionary:[self dictionaryForGochiWithEnergy:[NSNumber numberWithInt:50] experience:[NSNumber numberWithInt:90]]];
    [gochi setPetState:PET_STATE_TRAINING];
    return gochi;
}


@end
