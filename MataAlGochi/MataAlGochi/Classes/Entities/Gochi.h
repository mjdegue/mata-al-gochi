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
#import "Food.h"
@interface Gochi : NSObject

@property(strong, nonatomic) NSString* name;
@property(assign, nonatomic) PetIdentifier petType;
@property(assign, nonatomic) CGRect mouthRect;
@property(strong, nonatomic, readonly) NSNumber* energy;

//Constructor
-(instancetype) init;
-(instancetype) initWithName:(NSString*) name andPetType:(PetIdentifier) petType;

//Functional Methods
-(BOOL) feedWith:(Food*) food;

@end
