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
@property (nonatomic, strong) Gochi* ownGochi;
@property (nonatomic, strong) Gochi* activeGochi;

//Methods
- (void) update;

//Singleton methods
+(void) InitializeGame;
+(Game*) GetInstance;
+(void) DestroyInstance;

@end
