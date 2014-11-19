//
//  MainSceneViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "MainSceneViewController.h"
@interface MainSceneViewController ()

//Properties
@property (strong, nonatomic) NSString* gochisName;
@property (assign, nonatomic) PetIdentifier gochisAsset;

//IBOutlets
@property (strong, nonatomic) IBOutlet UIImageView *imgGochiImage;

@end

@implementation MainSceneViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gochisName:(NSString*) gochisName gochisAsset: (PetIdentifier) gochisAsset
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.gochisName = gochisName;
    [self setGochisAsset:gochisAsset];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:self.gochisName];
    [self refreshPetImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.imgGochiImage setImage:petImage];
}
@end
