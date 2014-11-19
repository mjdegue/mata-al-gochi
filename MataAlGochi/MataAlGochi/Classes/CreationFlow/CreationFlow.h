//
//  CreationFlow.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PetConstants.h"
#import "Gochi.h"
@interface CreationFlow : NSObject

//Creation flow methods:
-(void) setGochisName:(NSString*) gochisName;
-(NSString*) getGochisName;
-(void) setGochisPet:(PetIdentifier) petType;
-(BOOL) completeCreationFlow;
//Singleton methods
+(CreationFlow*) GetInstance;
+(void) DestroyInstance;
@end
