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
@property (nonatomic, strong) NSMutableArray* gochisList;
@end

@implementation Game

#pragma mark - GameSpecifics
- (void)update
{
    int gochisSize = (int)[self.gochisList count];
    
    for(int i = 0; i < gochisSize; ++i)
    {
        Gochi* gochi = [self.gochisList objectAtIndex:i];
        [gochi update];
    }
}

#pragma mark - Add gochis
- (void)addGochi:(Gochi *)gochi
{
    [self addGochi: gochi setAsActive:NO];
}

-(void)addGochi:(Gochi *)gochi setAsActive:(BOOL)setActive
{
    [self.gochisList addObject:gochi];
    if(setActive)
    {
        self.activeGochi = gochi;
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
    self.gochisList = [[NSMutableArray alloc] init];
    
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
