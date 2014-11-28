//
//  NotificationManager.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/28/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "Gochi.h"

#define NOTIFICATION_GOCHI_OBJ_KEY @"NOTIFICATION_GOCHI_OBJ_KEY"

@interface NotificationManager : NSObject

+ (void)sendLocalNotificationWithGochi:(Gochi*) gochi;
@end
