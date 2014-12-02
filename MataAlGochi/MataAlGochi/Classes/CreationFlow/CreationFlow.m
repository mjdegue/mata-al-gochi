//
//  CreationFlow.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "CreationFlow.h"
#import "Game.h"
#import "Gochi.h"
#import "Settings.h"
#import "NetworkRequestsHelper.h"

@interface CreationFlow ()
@property (nonatomic, strong) Gochi* futureGochi;
//Methods
-(instancetype)initFromSingleton;
@end


@implementation CreationFlow

//Creation flow specific methods:
-(void)setGochisPet:(PetIdentifier)petType
{
    [self.futureGochi setPetType:petType];
    BOOL selectedGochiType = petType != PET_INVALID;
    _completedSteps.selectedType = selectedGochiType;
    [[Settings sharedInstance] setIsGochiTypeSelected:[NSNumber numberWithBool:selectedGochiType]];
    [[Settings sharedInstance] setIsGochiFinished:[NSNumber numberWithBool:NO]];
}

-(void)setGochisName:(NSString *)gochisName
{
    [self.futureGochi setName:gochisName];
    BOOL selectedName = ![gochisName isEqualToString:@""];
    _completedSteps.selectedName = selectedName;
    [[Settings sharedInstance] setIsGochiNameSelected:[NSNumber numberWithBool:selectedName]];
    [[Settings sharedInstance] setIsGochiTypeSelected:[NSNumber numberWithBool:NO]];
    [[Settings sharedInstance] setIsGochiFinished:[NSNumber numberWithBool:NO]];
}

-(NSString*) getGochisName
{
    return [self.futureGochi name];
}

-(BOOL) completeCreationFlow
{
    if([self isGochiCompleted])
    {
        Game* game = [Game GetInstance];
        Gochi* gochi = [self futureGochi];
        [gochi setIsFinished:YES];
        [game addGochi:gochi setAsActive:YES];
        [[Settings sharedInstance] setIsGochiFinished:[NSNumber numberWithBool:YES]];
        [[NetworkRequestsHelper sharedInstance] postGochiOnServer:gochi];
        return YES;
    }
    return NO;
}

-(Gochi*) getUncompleteGochi
{
    return self.futureGochi;
}

-(void) setUncompletedGochi:(Gochi*)gochi
{
    self.futureGochi = gochi;
}
-(BOOL) isGochiCompleted
{
    if([self.futureGochi petType] == PET_INVALID)
    {
        return NO;
    }
    if([self.futureGochi.name isEqualToString:@""])
    {
        return NO;
    }
    return YES;
}


//Singleton Pattern methods:
static CreationFlow* instance = nil;

-(instancetype)init
{
    @throw @"You shall not call this";
    return [super init];
}

-(instancetype)initFromSingleton
{
    self = [super init];
    [self setFutureGochi:[[Gochi alloc] init]];
    return self;
}

+(CreationFlow *)GetInstance
{
    if(instance == nil)
    {
        instance =[[CreationFlow alloc] initFromSingleton];
    }
    return instance;
}

+(BOOL) isCreationFlowWorking
{
    return instance != nil;
}
+(void)DestroyInstance
{
    instance = nil;
}

#pragma mark - Storaging

#define COMPLETED_STEPS_NAME_KEY        @"CompletedStepsNameKey"
#define COMPLETED_STEPS_TYPE_KEY        @"CompletedStepsTypeKey"
#define INCOMPLETE_GOCHI_KEY            @"IncompleteGochiKey"

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self)
    {
        _completedSteps.selectedName = [[coder decodeObjectForKey:COMPLETED_STEPS_NAME_KEY] boolValue];
        _completedSteps.selectedName = [[coder decodeObjectForKey:COMPLETED_STEPS_TYPE_KEY] boolValue];
        _futureGochi = [coder decodeObjectForKey:INCOMPLETE_GOCHI_KEY];
    }
    instance = self;
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithBool:_completedSteps.selectedName ] forKey:COMPLETED_STEPS_NAME_KEY];
    [aCoder encodeObject:[NSNumber numberWithBool:_completedSteps.selectedType ] forKey:COMPLETED_STEPS_TYPE_KEY];
    [aCoder encodeObject:self.futureGochi forKey:INCOMPLETE_GOCHI_KEY];
}

#undef COMPLETED_STEPS_TYPE_KEY
#undef COMPLETED_STEPS_NAME_KEY
#undef INCOMPLETE_GOCHI_KEY


@end
