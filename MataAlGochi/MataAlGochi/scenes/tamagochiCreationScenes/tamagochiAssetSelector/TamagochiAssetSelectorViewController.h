//
//  TamagochiAssetSelectorViewController.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TamagochiAssetSelectorViewController : UIViewController

typedef enum
{
    PET_DEER = 0,
    PET_CAT,
    PET_GIRAFFE,
    PET_LION
} PetIdentifier;

//Init definition...
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gochisName:(NSString*) gochisName;

@end
