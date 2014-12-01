//
//  GochiInMapSceneViewController.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Gochi.h"

@interface GochiInMapSceneViewController : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) Gochi* gochi;

@end
