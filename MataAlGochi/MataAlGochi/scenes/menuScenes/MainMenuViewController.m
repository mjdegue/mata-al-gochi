//
//  MainMenuViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "MainMenuViewController.h"
#import "MainSceneViewController.h"
#import "TamagochiNameSelectionViewController.h"
#import "NetworkRequestsHelper.h"
#import "Game.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressPlayButton:(id)sender
{
    TamagochiNameSelectionViewController* nameSelectionView = [[TamagochiNameSelectionViewController alloc] initWithNibName:@"TamagochiNameSelectionViewController" bundle:nil];

    [nameSelectionView.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    [self.navigationController pushViewController:nameSelectionView animated:YES];
}


- (IBAction)didPressLoadFromCloud:(id)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLoadingPet:) name:NWNOTIFICATION_GOCHI_LOADED_SUCCED object:nil];
    [[NetworkRequestsHelper sharedInstance] getOwnGochiFromServer];
}

- (void) didFinishLoadingPet:(id) sender
{
    Gochi* gochi = [sender object];
    [[Game GetInstance] addGochi:gochi setAsActive:YES];
    MainSceneViewController* mainGameScene = [[MainSceneViewController alloc] initWithNibName:@"MainSceneViewController" bundle:nil];
    [self.navigationController pushViewController:mainGameScene animated:YES];
}

#pragma mark - Testing Network
/*
- (IBAction)networkingTestCall:(id)sender
{
    NetworkTestClass* net = [[NetworkTestClass alloc] init];
    [net callMethod];
}
*/
@end
