//
//  PetFactory.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/21/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gochi.h"

@interface PetFactory : NSObject

+ (Gochi*) createPetByPetType: (PetIdentifier) petType whichNameIs:(NSString*) petName;

@end
