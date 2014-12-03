//
//  CoreDataHelper.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/3/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Gochi.h"

@interface CoreDataHelper : NSObject
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory; // nice to have to reference files for core data

//custom methods:

- (Gochi*) allocGochi;

- (void) setGochi:(Gochi*) gochi;
- (void)setGochisByArray:(NSArray *)gochis;
- (void) deleteGochi:(Gochi*) gochi;
- (NSArray*) fetchAllGochis;

+ (instancetype) sharedInstance;

@end
