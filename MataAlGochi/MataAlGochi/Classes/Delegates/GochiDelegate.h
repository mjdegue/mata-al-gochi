//
//  GochiDelegate.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/24/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GochiDelegate <NSObject>

- (void) gochiChangedFromState:(PetStateIdentifier) previousState toState:(PetStateIdentifier) newState;
- (void) gochiEnergyModified;
@end
