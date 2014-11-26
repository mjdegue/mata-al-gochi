//
//  NetworkManager.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/26/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetworkManager : AFHTTPSessionManager
+ (instancetype)sharedInstance;
@end
