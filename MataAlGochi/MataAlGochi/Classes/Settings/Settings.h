//
//  Settings.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/2/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject<NSCoding>
@property (strong, nonatomic) NSNumber* isCreationFlowStarted;
@property (strong, nonatomic) NSNumber* isGochiFinished;
@property (strong, nonatomic) NSNumber* isGochiNameSelected;
@property (strong, nonatomic) NSNumber* isGochiTypeSelected;

+ (instancetype) sharedInstance;
+ (void) destroyInstance;
@end
