//
//  GameDelegate.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/24/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#ifndef MataAlGochi_GameDelegate_h
#define MataAlGochi_GameDelegate_h

@protocol GameDelegate <NSObject>

- (void) gameChangedToGochi:(Gochi*) newActiveGochi;

@end

#endif
