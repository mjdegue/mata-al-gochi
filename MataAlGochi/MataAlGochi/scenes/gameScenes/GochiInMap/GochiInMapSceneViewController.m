//
//  GochiInMapSceneViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "GochiInMapSceneViewController.h"
#import "Gochi.h"
#import "GochiSpotAnnotation.h"
@interface GochiInMapSceneViewController ()

//Properties
//IBOutlets
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation GochiInMapSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    //Add spot annotation
    GochiSpotAnnotation* spotAnnotation = [[GochiSpotAnnotation alloc] initWithGochi:self.gochi];
    [mapView addAnnotation:spotAnnotation];
    
    //Set map in region:
    MKCoordinateRegion region;
    region.center = self.gochi.location.coordinate;
    region.span.latitudeDelta = 0.02;
    region.span.longitudeDelta = 0.02;
    [mapView setRegion:region animated:YES];    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[GochiSpotAnnotation class]])
    {
        static NSString* identifier = @"GochiSpotAnnotation";
        GochiSpotAnnotation* myAnnotation = (GochiSpotAnnotation* )annotation;
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(annotationView == nil)
        {
            annotationView = [myAnnotation getAnnotationView];
        }
        else
        {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
}
@end
