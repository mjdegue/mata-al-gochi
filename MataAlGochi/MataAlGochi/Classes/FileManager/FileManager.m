//
//  FileManager.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/2/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "FileManager.h"


#define BASIC_FILE_PATH @"~/Library/Application Support/MataAlGochi/"

//For gochis
#define COMPLETE_GOCHI_FILE_NAME     @"gochi.txt"
#define INCOMPLETE_GOCHI_FILE_NAME   @"incompleteGochi.txt"

//For settings
#define SETTINGS_FILE_NAME           @"settings.txt"

#define CREATION_FLOW_FILE_NAME      @"creationFlow.txt"

@implementation FileManager

#pragma mark - Gochis
+ (void) saveGochi:(Gochi*) gochi
{
    NSString* filePath = [self getLocalFilePathForCompletedPet:YES];
    [NSKeyedArchiver archiveRootObject:gochi toFile:filePath];
}

+ (Gochi*) loadGochi
{
    NSString* filePath = [self getLocalFilePathForCompletedPet:YES];
    if([[NSFileManager defaultManager]fileExistsAtPath:filePath])
    {
        Gochi* gochi = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        return gochi;
    }
    return nil;
}

#pragma mark - Settings

+ (void)saveSettings
{
    NSString* filePath = [self getSettingsFilePath];
    [NSKeyedArchiver archiveRootObject:[Settings sharedInstance] toFile:filePath];
}

+ (void)loadSettings
{
    NSString* fp = [self getSettingsFilePath];
    if([[NSFileManager defaultManager]fileExistsAtPath:fp])
    {
        [NSKeyedUnarchiver unarchiveObjectWithFile:fp];
    }
}

#pragma mark - Creation FLow

+ (void)saveCreationFlow
{
    NSString* filePath = [self getCreationFlowFilePath];
    [NSKeyedArchiver archiveRootObject:[CreationFlow GetInstance] toFile:filePath];
}

+ (void) loadCreationFlow
{
    NSString* fp = [self getCreationFlowFilePath];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:fp])
    {
        [NSKeyedUnarchiver unarchiveObjectWithFile:fp];
    }
}


#pragma mark - filePaths
//TODO: Refactor from here
+ (NSString*) getLocalFilePathForCompletedPet:(BOOL) completed
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString* path = [BASIC_FILE_PATH stringByExpandingTildeInPath];
    if(![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [path stringByAppendingPathComponent:completed ? COMPLETE_GOCHI_FILE_NAME : INCOMPLETE_GOCHI_FILE_NAME];
}

+ (NSString*) getSettingsFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString* path = [BASIC_FILE_PATH stringByExpandingTildeInPath];
    if(![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [path stringByAppendingPathComponent:SETTINGS_FILE_NAME];
}

+ (NSString*) getCreationFlowFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString* path = [BASIC_FILE_PATH stringByExpandingTildeInPath];
    if(![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [path stringByAppendingPathComponent:CREATION_FLOW_FILE_NAME];
}


@end
