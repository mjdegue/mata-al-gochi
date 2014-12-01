//
//  RankingSceneViewController.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RankingSceneViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//Constructors
- (instancetype) initWithGochisList:(NSArray*) gochisList;

@end
