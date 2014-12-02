//
//  LocationHelper.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "LocationHelper.h"

@interface LocationHelper()

@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation* lastLocation;

@end

@implementation LocationHelper

- (void) startUpdates
{
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.distanceFilter = 10;
    [self.locationManager startUpdatingLocation];
}

- (void) stopLocation
{
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.lastLocation = [locations objectAtIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:MAP_LOCATION_UPDATED_NOTIFICATION object:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSDate* eventTime = newLocation.timestamp;
    NSTimeInterval howRecent = [eventTime timeIntervalSinceNow];
    if(abs(howRecent) < 120.0f)
    {
        self.lastLocation = newLocation;
    }
}


//Singleton again
static LocationHelper* instance = nil;
+ (instancetype) sharedInstance
{
    if(instance == nil)
    {
        instance = [[LocationHelper alloc] init];
    }
    return instance;
}

+ (void) destroyInstance
{
    instance = nil;
}

@end
