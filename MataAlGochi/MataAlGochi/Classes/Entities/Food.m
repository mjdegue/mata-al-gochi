//
//  Food.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/20/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "Food.h"

@implementation Food

-(instancetype) initFood:(FoodIdentifier)foodType whichNameIs:(NSString*)foodName andDescription:(NSString*) foodDescription
{
    self = [super init];
    self.FoodType = foodType;
    self.FoodName = foodName;
    self.FoodDescription = foodDescription;
    
    return self;
}
@end
