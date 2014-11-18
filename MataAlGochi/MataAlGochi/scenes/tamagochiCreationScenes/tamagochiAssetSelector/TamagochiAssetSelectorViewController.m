//
//  TamagochiAssetSelectorViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "TamagochiAssetSelectorViewController.h"

@interface TamagochiAssetSelectorViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lblGochisName;
@property (strong, nonatomic) IBOutlet UIImageView *imgPetPreview;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollPetSelector;


@end

@implementation TamagochiAssetSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        NSString* gochisName = @"Hardcoded Gochis' Name";
    [self.lblGochisName setText:gochisName];
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
    PetIdentifier pet = (PetIdentifier)[sender tag];
    
    NSString* imageName;
    switch (pet) {
        default:
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

@end
