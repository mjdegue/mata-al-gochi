//
//  LocationHelper.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface LocationHelper : NSObject<CLLocationManagerDelegate>

@property (strong, nonatomic, readonly) CLLocation* lastLocation;

- (void) startUpdates;

//singleton
+ (instancetype) sharedInstance;

@end
