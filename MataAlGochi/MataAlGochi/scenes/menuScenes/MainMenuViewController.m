//
//  MainMenuViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "MainMenuViewController.h"
#import "TamagochiNameSelectionViewController.h"


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




@end
