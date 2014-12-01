//
//  GochiSpotAnnotation.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Gochi.h"

@interface GochiSpotAnnotation : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString* title;
@property (nonatomic, copy, readonly) NSString* subtitle;
@property (nonatomic, copy, readonly) NSString* image;

-(instancetype) initWithGochi:(Gochi*) gochi;
-(MKAnnotationView*) getAnnotationView;
@end
