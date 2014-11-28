//
//  NotificationManager.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/28/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "NotificationManager.h"
#import <Parse/Parse.h>

#define PARSE_CHANNEL_PET_FIGHT @"PeleaDeMascotas"

@implementation NotificationManager

+ (void)suscribeToGochisFightChannel
{
    PFInstallation* installation = [PFInstallation currentInstallation];
    [installation addUniqueObject:PARSE_CHANNEL_PET_FIGHT forKey:@"channels"];
    [installation saveInBackground];
}

+(void)unsuscribeToGochisFightChannel
{
    PFInstallation* installation = [PFInstallation currentInstallation];
    [installation removeObject:PARSE_CHANNEL_PET_FIGHT forKey:@"channels"];
    [installation saveInBackground];
}

+ (void) pushLevelupGochiNotification:(Gochi*) gochi
{
    // Send a notification to all devices subscribed to the "Giants" channel.
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:PARSE_CHANNEL_PET_FIGHT];
    [push setMessage:[[NSString alloc] initWithFormat:@"%@ just got level %@", gochi.name, gochi.level]];
    [push setData:[gochi dictionaryByGochi]];
    [push sendPushInBackground];
}

+ (void)sendLocalNotificationWithGochi:(Gochi*) gochi
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    [localNotification setAlertBody:[[NSString alloc] initWithFormat:@"Cuidado! %@ esta cansado!", gochi.name]];
    [localNotification setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.0f]];
    [localNotification setUserInfo:[gochi dictionaryByGochi]];
     [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}
@end
