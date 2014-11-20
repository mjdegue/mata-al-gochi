//
//  Game.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "Game.h"

@implementation Game


-(void)setOwnGochi:(Gochi *)ownGochi
{
    _ownGochi = ownGochi;
    _activeGochi = ownGochi;
}


//Singleton Methods
static Game* instance = nil;

+(void)InitializeGame
{
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Game alloc] initFromSingleton];
    });
}
+(Game *)GetInstance
{
   return instance;
}

-(instancetype) initFromSingleton
{
    self = [super init];
    
    return self;
}

- (instancetype)init
{
    @throw @"You shall not call this";
    return [super init];
}
+(void)DestroyInstance
{
    instance = nil;
}

@end
