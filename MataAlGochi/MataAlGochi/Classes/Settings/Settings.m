//
//  Settings.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/2/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "Settings.h"

@implementation Settings


static Settings* instance = nil;
+ (instancetype) sharedInstance
{
    if(instance == nil)
    {
        instance = [[Settings alloc] init];
    }
    return instance;
}

+ (void)destroyInstance
{
    instance = nil;
}


#pragma mark - Save to disk

#define COMPLETED_FLOW_KEY @"CompletedFlowKey"
#define COMPLETED_NAME_KEY @"CompletedNameKey"
#define COMPLETED_TYPE_KEY @"CompletedTypeKey"
#define STARTED_FLOW_KEY   @"StartedFlowKey"

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.isGochiFinished forKey:COMPLETED_FLOW_KEY];
    [aCoder encodeObject:self.isGochiNameSelected forKey:COMPLETED_NAME_KEY];
    [aCoder encodeObject:self.isGochiTypeSelected forKey:COMPLETED_TYPE_KEY];
    [aCoder encodeObject:self.isCreationFlowStarted forKey:STARTED_FLOW_KEY];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.isGochiFinished = [aDecoder decodeObjectForKey:COMPLETED_FLOW_KEY];
        self.isGochiNameSelected = [aDecoder decodeObjectForKey:COMPLETED_NAME_KEY];
        self.isGochiTypeSelected = [aDecoder decodeObjectForKey:COMPLETED_TYPE_KEY];
        self.isCreationFlowStarted = [aDecoder decodeObjectForKey:STARTED_FLOW_KEY];
    }
    instance = self;
    return self;
}

#undef COMPLETED_FLOW_KEY
#undef COMPLETED_NAME_KEY
#undef COMPLETED_TYPE_KEY


@end
