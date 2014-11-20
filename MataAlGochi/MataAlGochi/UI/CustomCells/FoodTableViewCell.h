//
//  FoodTableViewCell.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/20/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

static NSString* FoodTableViewCellReuseStringIdentifier = @"FOOD_TABLE_VIEW_CELL_IDENTIFIER";
static NSString* FoodTableViewCellNibString = @"FoodTableViewCell";

@interface FoodTableViewCell : UITableViewCell
//Properties

@property (strong, nonatomic) IBOutlet UIImageView *foodImage;
@property (strong, nonatomic) IBOutlet UILabel *foodName;
@property (strong, nonatomic) IBOutlet UILabel *foodDescription;

-(instancetype) initWithFood: (Food*) food;
-(void) setFood:(Food*) food;

@end
