//
//  ImageLoader.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/20/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "ImageLoader.h"

@implementation ImageLoader

+ (UIImage*) loadFoodImageByType:(FoodIdentifier)foodType
{
    NSString* imageName;
    switch (foodType)
    {
        default:
        case FOOD_CAKE:
            imageName = @"comida_0";
            break;
        case FOOD_CAKE_TWO:
            imageName = @"comida_1";
            break;
        case FOOD_ICE_CREAM:
            imageName = @"comida_2";
            break;
        case FOOD_CHICKEN:
            imageName = @"comida_3";
            break;
        case FOOD_BURGER:
            imageName = @"comida_4";
            break;
        case FOOD_LEMON_FISH:
            imageName = @"comida_5";
            break;
        case FOOD_APPLE:
            imageName = @"comida_6";
            break;
        case FOOD_SAUSAGE:
            imageName = @"comida_7";
            break;
        case FOOD_BREAD:
            imageName = @"comida_8";
            break;
    }
    UIImage* foodImage = [UIImage imageNamed:imageName];
    return foodImage;
}

+ (UIImage*) loadPetImageByType:(PetIdentifier)petType
{
    NSString* imageName;
    switch (petType)
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
    return petImage;
}

@end
