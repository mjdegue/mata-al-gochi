//
//  FileManager.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/2/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gochi.h"
#import "CreationFlow.h"
#import "Settings.h"

@interface FileManager : NSObject

+ (void) saveGochi:(Gochi*) gochi;
+ (Gochi*) loadGochi;

+ (void) saveSettings;
+ (void) loadSettings;

+ (void) saveCreationFlow;
+ (void) loadCreationFlow;

@end
