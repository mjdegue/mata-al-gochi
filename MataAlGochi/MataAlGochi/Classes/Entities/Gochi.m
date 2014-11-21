//
//  Gochi.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "Gochi.h"
#import "CreationFlow.h"

@interface Gochi ()
@end

@implementation Gochi

#pragma mark - Constructors
-(instancetype) init
{
    self = [super init];
    [self setName:@""];
    [self setPetType:PET_INVALID];
    _energy = [[NSNumber alloc] initWithFloat:50.0f];
    return self;
}

-(instancetype)initWithName:(NSString *)name andPetType:(PetIdentifier)petType
{
    self = [super init];
    [self setPetType:petType];
    [self setName:name];
    _energy = [[NSNumber alloc] initWithFloat:50.0f];
    return self;
}

#pragma mark - Functional Methods
-(BOOL) feedWith:(Food*) food
{
    if([_energy floatValue] == 100.0f)
    {
        return NO;
    }
    
    NSNumber* foodRecharge = [food RechargeAmmount];
    _energy = [[NSNumber alloc] initWithFloat:([_energy floatValue] + [foodRecharge floatValue])];

    return YES;
}
@end
