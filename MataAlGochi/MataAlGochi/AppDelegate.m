//
//  AppDelegate.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "AppDelegate.h"
#import "MainMenuViewController.h"
#import "Game.h"
#import "NotificationManager.h"
#import "NotificationConstants.h"
#import <Parse/Parse.h>
#import "LocationHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Starts windows and navs initialization:
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainMenuViewController* mainMenu = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    UINavigationController* navControllerHome = [[UINavigationController alloc] initWithRootViewController:mainMenu];
    
    [navControllerHome.navigationBar setBarStyle:UIBarStyleBlackTranslucent];

    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.window setRootViewController:navControllerHome];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //Ends windows and navs initializations.
    
    //Register for local notifications
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        [application registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |                                                                               UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    //Parse stuff
    [Parse setApplicationId:@"guhchukKgURzzZVCHBFOxyD35VHeMQm3EUZEdJvD"
                  clientKey:@"SnnbrQ9yOemJspA7LRt1MCACFFUYNkbQ1k2IM1vH"];
    
    //End register push notifications
    
    
    //Starts game initialization
    [Game InitializeGame];
    //ends Game initialization
    
    //Starts tracking illegaly the user to fill CIA projects info:
    [[LocationHelper sharedInstance] startUpdates];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler
{
    NSString* code = userInfo[@"code"];
    if(! [code isEqualToString:OWN_GOCHI_ID])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_FIGHTING_GOCHI_GOT_INFO object:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    /* @TODO: Check here how to define if user comes from background or not, and how to show the gochi in that case
     
    NSDictionary* gochiDictionary = [notification userInfo];
    if([self.window.rootViewController.nibName isEqualToString:@"MainSceneViewController"])
    {
        NSLog(@"Esta en esa pantalla");
    }
    else
    {
        NSLog(@"DSADASDSA pantalla");
    }*/
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
