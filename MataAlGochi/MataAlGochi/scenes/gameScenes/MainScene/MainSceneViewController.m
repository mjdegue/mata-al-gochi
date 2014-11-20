//
//  MainSceneViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "MainSceneViewController.h"
#import "Game.h"
#import "Gochi.h"
#import "ImageLoader.h"

@interface MainSceneViewController ()

//Properties
@property(nonatomic,strong) Gochi* activeGochi;
@property(nonatomic,strong) Game* gameInstance;

//IBOutlets
@property (strong, nonatomic) IBOutlet UIImageView *imgGochiImage;
@property (strong, nonatomic) IBOutlet UIImageView *imgFood;

@end

@implementation MainSceneViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setGameInstance:[Game GetInstance]];
    return self;
}

#pragma mark - ViewController specific
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Game instance setup
    [self setGameInstance:[Game GetInstance]];
    
    //Gochi methods
    [self setActiveGochi:[self.gameInstance activeGochi]];
    [self setTitle:[self.activeGochi name]];
    [self refreshPetImage];
    
    //Modify the UIBar
    UIBarButtonItem* optionsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(goToFeedScreen:)];
    
    self.navigationItem.rightBarButtonItem = optionsButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void) goToFeedScreen: (id) sender
{
    FeedSceneViewController* feedScene = [[FeedSceneViewController alloc] initWithNibName:@"FeedSceneViewController" bundle:nil];
    
    feedScene.foodDelegate = self;
    
    [self.navigationController pushViewController:feedScene animated:true];
}

#pragma mark - Visualization
- (void) refreshPetImage
{
    NSString* imageName;
    switch ([[self activeGochi] petType])
    {
        default: //Default value is just for avoid crashes
        case PET_CAT:
            imageName = @"gato_comiendo_1";
            break;
            
        case PET_DEER:
            imageName = @"ciervo_comiendo_1";
            break;
            
        case PET_GIRAFFE:
            imageName = @"jirafa_comiendo_1";
            break;
            
        case PET_LION:
            imageName = @"leon_comiendo_1";
            break;
    }
    UIImage* petImage = [UIImage imageNamed:imageName];
    [self.imgGochiImage setImage:petImage];
}

#pragma mark - FoodDelegate

- (void) feedGochiWithFood: (Food*) food
{
    [self.activeGochi feedWith:food];
    [self.imgFood setImage:[ImageLoader loadFoodImageByType:[food FoodType]]];
}

@end

