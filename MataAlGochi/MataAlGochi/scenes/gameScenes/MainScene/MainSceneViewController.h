//
//  MainSceneViewController.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TamagochiAssetSelectorViewController.h"
@interface MainSceneViewController : UIViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gochisName:(NSString*) gochisName gochisAsset: (PetIdentifier) gochisAsset;
@end
