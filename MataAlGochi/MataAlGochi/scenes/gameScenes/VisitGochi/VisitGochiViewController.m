//
//  VisitGochiViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/4/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "VisitGochiViewController.h"
#import "ImageLoader.h"
@interface VisitGochiViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lblPetName;
@property (strong, nonatomic) IBOutlet UIImageView *imgPetImage;
@property (strong, nonatomic) IBOutlet UILabel *lblPetLevel;
@property (strong, nonatomic) IBOutlet UILabel *lblPetExpe;

@end

@implementation VisitGochiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.lblPetName setText:self.gochi.name];
    NSString* levelFormat = @"Level: %@";
    [self.lblPetLevel setText:[NSString stringWithFormat:levelFormat, self.gochi.level]];
    
    
    NSString* expFormat = @"Exp: %@ / %@";
    [self.lblPetExpe setText:[NSString stringWithFormat:expFormat, self.gochi.experience, self.gochi.maxExperience]];
    
    [self.imgPetImage setImage:[ImageLoader loadPetImageByType:self.gochi.petType]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
