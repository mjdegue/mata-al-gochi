//
//  MainSceneViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "MainSceneViewController.h"

@interface MainSceneViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lblGochisName;

@end

@implementation MainSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString* gochisName = @"Hardcoded gochis name";
    [self.lblGochisName setText:gochisName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
