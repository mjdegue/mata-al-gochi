//
//  TamagochiAssetSelectorViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "TamagochiAssetSelectorViewController.h"
#import "MainSceneViewController.h"

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

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gochisName:(NSString*) gochisName
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.gochisName = gochisName;
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
    NSString* imageName;
    switch ([self gochisAsset])
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
    [self.imgPetPreview setImage:petImage];
}

//Continue Navigation
- (IBAction)didPressContinue:(id)sender
{
    MainSceneViewController* mainGameScene = [[MainSceneViewController alloc] initWithNibName:@"MainSceneViewController" bundle:nil gochisName:[self gochisName] gochisAsset:[self gochisAsset]];
    [self.navigationController pushViewController:mainGameScene animated:YES];
}


@end
