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

typedef struct
{
    BOOL selectedName;
    BOOL selectedType;
}CreationFlowCompletedSteps;


@interface CreationFlow : NSObject <NSCoding>
@property (nonatomic, assign) CreationFlowCompletedSteps completedSteps;

//Creation flow methods:

-(void) setGochisName:(NSString*) gochisName;
-(NSString*) getGochisName;
-(void) setGochisPet:(PetIdentifier) petType;
-(BOOL) completeCreationFlow;
-(Gochi*) getUncompleteGochi;
-(void) setUncompletedGochi:(Gochi*)gochi;

//Singleton methods
+(CreationFlow*) GetInstance;
+(void) DestroyInstance;
+(BOOL) isCreationFlowWorking;
@end
