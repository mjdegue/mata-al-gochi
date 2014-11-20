//
//  FoodTableViewCell.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/20/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "FoodTableViewCell.h"
#import "ImageLoader.h"
@implementation FoodTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Constructor

-(instancetype) initWithFood: (Food*) food
{
    self = [super init];
    [self setFood:food];
    
    return self;
}

-(void) setFood:(Food*) food
{
    [self.foodImage setImage:[ImageLoader loadFoodImageByType:[food FoodType]]];
    [self.foodDescription setText:[food FoodDescription]];
    [self.foodName setText:[food FoodName]];
}

@end
