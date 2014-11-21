//
//  TamagochiAssetSelectorViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "TamagochiAssetSelectorViewController.h"
#import "MainSceneViewController.h"
#import "ImageLoader.h"
#import "CreationFlow.h"
#import "Game.h"

@interface TamagochiAssetSelectorViewController ()

//Properties
@property (strong, nonatomic) NSString* gochisName;
@property (assign, nonatomic) PetIdentifier gochisAsset;

//IBOutlets:
@property (strong, nonatomic) IBOutlet UIImageView *imgPetPreview;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollPetSelector;


@end

@implementation TamagochiAssetSelectorViewController

//Csontructor:
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.gochisName = [[CreationFlow GetInstance] getGochisName];
    return self;
}

//Load general info
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle: self.gochisName];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.scrollPetSelector setScrollEnabled:YES];
    [self.scrollPetSelector setContentSize:CGSizeMake(437, 128)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSelectPet:(UIButton *)sender
{
    PetIdentifier gochisAsset = (PetIdentifier)[sender tag];
    [self setGochisAsset:gochisAsset];
    [self refreshPetImage];
}

- (void) refreshPetImage
{
    [self.imgPetPreview setImage:[ImageLoader loadPetImageByType:[self gochisAsset]]];
}

//Continue Navigation
- (IBAction)didPressContinue:(id)sender
{
    CreationFlow* creationFlow = [CreationFlow GetInstance];
    [creationFlow setGochisPet:[self gochisAsset]];
    
    BOOL didFinishCreationFlow = [creationFlow completeCreationFlow];
    if(!didFinishCreationFlow)
    {
        return;
    }
    
    //Destroy instance of CreationFlow since it's no longer needed
    [CreationFlow DestroyInstance];
    MainSceneViewController* mainGameScene = [[MainSceneViewController alloc] initWithNibName:@"MainSceneViewController" bundle:nil];
    [self.navigationController pushViewController:mainGameScene animated:YES];
}


@end
