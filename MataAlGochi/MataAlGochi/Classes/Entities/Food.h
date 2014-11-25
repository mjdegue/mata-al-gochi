//
//  Food.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/20/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodConstants.h"
@interface Food : NSObject
@property (assign, nonatomic) FoodIdentifier FoodType;
@property (strong, nonatomic) NSString* FoodName;
@property (strong, nonatomic) NSString* FoodDescription;
@property (strong, nonatomic) NSNumber* RechargeAmmount;

-(instancetype) initFood:(FoodIdentifier)foodType whichNameIs:(NSString*)foodName andDescription:(NSString*) foodDescription andFoodRecharge:(NSNumber*) recharge;
@end
