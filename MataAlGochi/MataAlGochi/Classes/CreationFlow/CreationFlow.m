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
}

-(void)setGochisName:(NSString *)gochisName
{
    [self.futureGochi setName:gochisName];
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
        [game setOwnGochi:[self futureGochi]];
        return YES;
    }
    return NO;
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

+(void)DestroyInstance
{
    instance = nil;
}

@end
