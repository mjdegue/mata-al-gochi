//
//  Gochi.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PetConstants.h"
#import "GochiDelegate.h"
#import "Food.h"

#define OWN_GOCHI_ID @"MD_7693"

@interface Gochi : NSObject

//Pet properties
@property(strong, nonatomic) NSString* name;
@property(assign, nonatomic) PetIdentifier petType;
@property(assign, nonatomic) PetStateIdentifier petState;

//Attributes
@property(strong, nonatomic, readonly) NSNumber* energy;
@property(strong, nonatomic, readonly) NSNumber* experience;
@property(strong, nonatomic, readonly) NSNumber* maxExperience;
@property(strong, nonatomic, readonly) NSNumber* level;

//Delegate specific
@property(strong, nonatomic) id<GochiDelegate> delegate;

//Constructor
-(instancetype) init;
-(instancetype) initWithName:(NSString*) name andPetType:(PetIdentifier) petType;

//Networking helper methods
-(NSDictionary*) dictionaryByGochi;
-(instancetype) initWithDictionary:(NSDictionary*) dictionary;

//Functional Methods
- (void) feedWith:(Food*) food;
- (void) train;
- (void) stopTraining;

- (void) update;

//

@end
