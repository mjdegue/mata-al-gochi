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
@property (nonatomic, strong) NSMutableArray* foodArray;
@end

@implementation Gochi

#pragma mark - Constructors
-(instancetype) init
{
    self = [super init];
    self.foodArray = [[NSMutableArray alloc] init];
    [self setName:@""];
    [self setPetType:PET_INVALID];
    return self;
}

-(instancetype)initWithName:(NSString *)name andPetType:(PetIdentifier)petType
{
    self = [super init];
    self.foodArray = [[NSMutableArray alloc] init];
    [self setPetType:petType];
    [self setName:name];
    return self;
}

#pragma mark - Functional Methods
-(void) feedWith:(Food*) food
{
    [self.foodArray addObject:food];
}
@end
