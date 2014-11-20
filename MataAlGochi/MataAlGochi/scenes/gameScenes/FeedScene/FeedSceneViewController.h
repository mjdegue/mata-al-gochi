//
//  FeedSceneViewController.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/20/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Food.h"

@protocol FoodDelegate <NSObject>
- (void) feedGochiWithFood: (Food*) food;
@end

@interface FeedSceneViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,weak) id<FoodDelegate> foodDelegate;
@end
