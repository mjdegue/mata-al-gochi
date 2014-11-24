//
//  Game.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "Game.h"

@interface Game()
@property (strong, nonatomic) NSTimer* updateTimer;
@end

@implementation Game

-(void)setOwnGochi:(Gochi *)ownGochi
{
    _ownGochi = ownGochi;
    _activeGochi = ownGochi;
}


#pragma mark - GameSpecifics
- (void)update
{
    NSLog(@"Update gochi");
    if(self.ownGochi != nil)
    {
        [self.ownGochi update];
    }
}


#pragma mark - Singleton
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
    
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    
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
