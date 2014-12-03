//
//  CoreDataHelper.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/3/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


#pragma mark -CoreData Gochi

- (void)setGochisByArray:(NSArray *)gochis
{
    for(Gochi* gochi in gochis)
    {
        [self setGochi:gochi];
    }
    /*
    NSManagedObjectContext* objectContext = [self managedObjectContext];
    
    for(Gochi* gochi in gochis)
    {
        NSManagedObject *gochiRow = [NSEntityDescription insertNewObjectForEntityForName:@"Gochi"
                                                              inManagedObjectContext:objectContext];
    
        [gochiRow setValue:gochi.code forKey:@"code"];
        [gochiRow setValue:gochi.energy forKey:@"energy"];
        [gochiRow setValue:gochi.experience forKey:@"experience"];
        [gochiRow setValue:gochi.maxExperience forKey:@"maxExperience"];
        [gochiRow setValue:[NSNumber numberWithDouble:gochi.location.coordinate.latitude] forKey:@"latitude"];
        [gochiRow setValue:[NSNumber numberWithDouble:gochi.location.coordinate.longitude] forKey:@"longitude"];
        [gochiRow setValue:gochi.level forKey:@"level"];
        [gochiRow setValue:gochi.name forKey:@"name"];
        [gochiRow setValue:[NSNumber numberWithInt:gochi.petState] forKey:@"petState"];
        [gochiRow setValue:[NSNumber numberWithInt:gochi.petType] forKey:@"petType"];
    }
    
    NSError* error = nil;
    if(![objectContext save:&error])
    {
        NSLog(@"Error saving: %@",[error localizedDescription]);
        [objectContext rollback];
    }*/
}

- (Gochi*) allocGochi
{
    NSEntityDescription* ent = [NSEntityDescription entityForName:@"Gochi" inManagedObjectContext:[self managedObjectContext]];
    Gochi* ans = [[Gochi alloc] initWithEntity:ent insertIntoManagedObjectContext:nil];
    return ans;
}

- (void)setGochi:(Gochi *)gochi
{
    //May check for update an existing gochi
    [self insertNewGochi:gochi];
}

- (void) insertNewGochi:(Gochi*) gochi
{
    NSManagedObjectContext* objectContext = [self managedObjectContext];
    
    NSManagedObject *gochiRow = [NSEntityDescription insertNewObjectForEntityForName:@"Gochi"
                                                           inManagedObjectContext:objectContext];
    
    [gochiRow setValue:gochi.code forKey:@"code"];
    [gochiRow setValue:gochi.energy forKey:@"energy"];
    [gochiRow setValue:gochi.experience forKey:@"experience"];
    [gochiRow setValue:gochi.maxExperience forKey:@"maxExperience"];
    [gochiRow setValue:[NSNumber numberWithDouble:gochi.location.coordinate.latitude] forKey:@"latitude"];
    [gochiRow setValue:[NSNumber numberWithDouble:gochi.location.coordinate.longitude] forKey:@"longitude"];
    [gochiRow setValue:gochi.level forKey:@"level"];
    [gochiRow setValue:gochi.name forKey:@"name"];
    [gochiRow setValue:[NSNumber numberWithInt:gochi.petState] forKey:@"petState"];
    [gochiRow setValue:[NSNumber numberWithInt:gochi.petType] forKey:@"petType"];
    
    NSError* error = nil;
    if(![objectContext save:&error])
    {
        NSLog(@"Error saving: %@",[error localizedDescription]);
        [objectContext rollback];
    }
}

- (void) updateExistingGochi:(Gochi*) gochi
{
    //nothing here yet :)
}

- (void) deleteGochi:(Gochi*) gochi
{
    NSManagedObjectContext* objectContext = [self managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Gochi" inManagedObjectContext:objectContext];
    
    [request setEntity:entity];
    [request setIncludesPropertyValues:(gochi != nil)];
    if(gochi != nil)
    {
        //add request for gochi by code, not yet :)
    }
    
    NSError* error;
    NSArray* gochis = [objectContext executeFetchRequest:request error:&error];
    
    if(error != nil)
    {
        //check for errors
        NSLog(@"Error, %@", [error localizedDescription]);
        return;
    }
    
    for(NSManagedObject* gochiRow in gochis)
    {
        [objectContext deleteObject:gochiRow];
    }
    
    if(![objectContext save:&error])
    {
        //check for errors
        NSLog(@"Error, %@", [error localizedDescription]);
        [objectContext rollback];
        return;
    }
    
}

- (NSArray*) fetchAllGochis
{
    NSMutableArray* returnableGochis = [[NSMutableArray alloc] init];

    NSManagedObjectContext* objectContext = [self managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Gochi" inManagedObjectContext:objectContext];
    
    [request setEntity:entity];
    [request setIncludesPropertyValues:YES];
    [request setReturnsObjectsAsFaults:NO];
    
    NSError* error;
    NSArray* gochiRows = [objectContext executeFetchRequest:request error:&error];
    
    if(error != nil)
    {
        //check for errors
        NSLog(@"Error, %@", [error localizedDescription]);
        return nil;
    }
    
    for(Gochi* gochiRow in gochiRows)
    {
        [returnableGochis addObject:gochiRow];
    }
    
    return returnableGochis;
}


#pragma mark - Singleton

static CoreDataHelper* instance = nil;
+ (instancetype) sharedInstance
{
    if(instance == nil)
    {
        instance = [[CoreDataHelper alloc] init];
    }
    return instance;
}


#pragma mark - CoreData core

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MataAlGochi.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
