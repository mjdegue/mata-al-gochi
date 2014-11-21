//
//  PetConstants.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#ifndef MataAlGochi_PetConstants_h
#define MataAlGochi_PetConstants_h

typedef enum
{
    PET_INVALID = -1,
    PET_DEER = 0,
    PET_CAT,
    PET_GIRAFFE,
    PET_LION
} PetIdentifier;

typedef enum
{
    PET_STATE_INVALID = -1,
    PET_STATE_FIRST = 0,
    PET_STATE_EATING = 0,
    PET_STATE_TRAINING,
    PET_STATE_TIRED,
    PET_STATE_LAST = PET_STATE_TIRED    
    
} PetStateIdentifier;

#endif
