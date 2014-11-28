//
//  NotificationManager.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/28/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "NotificationManager.h"
#import <Parse/Parse.h>

@implementation NotificationManager

+ (void)sendLocalNotificationWithGochi:(Gochi*) gochi
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    [localNotification setAlertBody:[[NSString alloc] initWithFormat:@"Cuidado! %@ esta cansado!", gochi.name]];
    [localNotification setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.0f]];
    [localNotification setUserInfo:[gochi dictionaryByGochi]];
     [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}
@end
