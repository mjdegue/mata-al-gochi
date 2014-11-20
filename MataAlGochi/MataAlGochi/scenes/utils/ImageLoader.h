//
//  ImageLoader.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/20/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PetConstants.h"
#import "FoodConstants.h"
@interface ImageLoader : NSObject

+ (UIImage*) loadPetImageByType: (PetIdentifier) petType;
+ (UIImage*) loadFoodImageByType: (FoodIdentifier) foodType;


@end
