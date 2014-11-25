//
//  Game.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gochi.h"
@interface Game : NSObject

//Properties
@property (nonatomic, strong) Gochi* activeGochi;

//Methods
- (void) update;
- (void) addGochi:(Gochi*) gochi;
- (void) addGochi:(Gochi*) gochi setAsActive:(BOOL) setActive;

//Singleton methods
+(void) InitializeGame;
+(Game*) GetInstance;
+(void) DestroyInstance;

@end
