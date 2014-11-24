//
//  PetFactory.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/21/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "PetFactory.h"

@implementation PetFactory


+ (Gochi*) createPetByPetType: (PetIdentifier) petType whichNameIs:(NSString*) petName;
{
    Gochi* gochi = [[Gochi alloc] initWithName: petName andPetType:petType ];

    return gochi;
}

@end
