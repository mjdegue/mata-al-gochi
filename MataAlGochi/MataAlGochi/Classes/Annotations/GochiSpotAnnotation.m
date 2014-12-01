//
//  GochiSpotAnnotation.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "GochiSpotAnnotation.h"
#import "ImageLoader.h"



@implementation GochiSpotAnnotation


-(instancetype) initWithGochi:(Gochi*) gochi
{
    self = [super init];
    if(self)
    {
        _title = gochi.name;
        _subtitle = [NSString stringWithFormat:@"Level: %@", gochi.level];
        
        CGRect rect;
        rect.origin.x = rect.origin.y = 0;
        rect.size.height = rect.size.width = 50;
        
        _image = [ImageLoader imageNameByPetType:gochi.petType];
        
        self.coordinate = gochi.location.coordinate;
    }
    return self;
}


-(MKAnnotationView*) getAnnotationView
{
    MKAnnotationView* view = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"GochiSpotAnnotation"];
    view.enabled = YES;
    view.canShowCallout = YES;
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.image]];
    imageView.frame = CGRectMake(0, 0, 40, 40);
    
    view.leftCalloutAccessoryView = imageView;
    
    view.image = [UIImage imageNamed:self.image];
    view.bounds = CGRectMake(0, 0, 40, 40);
    
    
    return view;
}


@end
