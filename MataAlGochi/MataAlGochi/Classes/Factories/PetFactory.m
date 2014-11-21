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
    CGRect mouthRect;
    
    switch (petType) {
        case PET_CAT:
            mouthRect.origin.x = 105;
            mouthRect.origin.y = 130;
            mouthRect.size.width = 25;
            mouthRect.size.height = 15;
            break;
        case PET_LION:
            mouthRect.origin.x = 115;
            mouthRect.origin.y = 190;
            mouthRect.size.width = 30;
            mouthRect.size.height = 10;
            break;
        case PET_DEER:
            mouthRect.origin.x = 150;
            mouthRect.origin.y = 130;
            mouthRect.size.width = 25;
            mouthRect.size.height = 10;
            break;
        case PET_GIRAFFE:
            mouthRect.origin.x = 145;
            mouthRect.origin.y = 80;
            mouthRect.size.width = 30;
            mouthRect.size.height = 12;
            break;
        default:
            break;
    }
    
    [gochi setMouthRect:mouthRect];
    return gochi;
}

@end
