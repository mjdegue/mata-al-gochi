//
//  Gochi.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/19/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "Gochi.h"
#import "CreationFlow.h"
#import "NSTimer+TimerSafeInvalidate.h"
#import "NetworkRequestsHelper.h"
#import "NotificationManager.h"
#import "LocationHelper.h"

#define ENERGY_MULTIPLIER_REST  (-1.0f)
#define ENERGY_MULTIPLIER_TRAIN (-10.0f)
#define ENERGY_MULTIPLIER_EAT   (1.0f)

#define EXPERIENCE_MULTIPLIER_BY_TRAIN 15

#define TIMER_EATING_DURATION 2.0f

@interface Gochi ()
@property (strong, nonatomic) NSTimer* stateTimer;
@property (strong, nonatomic) Food* eatingFood;
@end

@implementation Gochi

#pragma mark - Constructors
-(instancetype) init
{
    self = [super init];
    [self setName:@""];
    [self setPetType:PET_INVALID];
    _energy = [[NSNumber alloc] initWithFloat:50.0f];
    _level = [[NSNumber alloc] initWithInt:1];
    _experience = [[NSNumber alloc] initWithInt:0];
    _maxExperience = [[NSNumber alloc] initWithInt:([self.level intValue] * [self.level intValue] * 100)];
    _code = OWN_GOCHI_ID;
    _location = [[LocationHelper sharedInstance] lastLocation];
    
    //Add notification observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateGochiLocation) name:MAP_LOCATION_UPDATED_NOTIFICATION object:nil];
    
    return self;
}

-(instancetype)initWithName:(NSString *)name andPetType:(PetIdentifier)petType
{
    self = [super init];
    [self setPetType:petType];
    [self setName:name];
    [self setPetState:PET_STATE_RESTING];
    _energy = [[NSNumber alloc] initWithFloat:50.0f];
    _maxExperience = [[NSNumber alloc] initWithInt:([self.level intValue] * [self.level intValue] * 100)];
    _code = OWN_GOCHI_ID;
    _location = [[LocationHelper sharedInstance] lastLocation];
    
    //Add notification observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateGochiLocation) name:MAP_LOCATION_UPDATED_NOTIFICATION object:nil];
    
    return self;
}

#pragma mark - Functional Methods
-(void) feedWith:(Food*) food
{
    [self stateChange:PET_STATE_EATING];
    [self setEatingFood:food];
    self.stateTimer = [NSTimer scheduledTimerWithTimeInterval:TIMER_EATING_DURATION target:self selector:@selector(stopEating) userInfo:nil repeats:NO];
}
                       
-(void) stopEating
{
    [self stateChange:PET_STATE_RESTING];
}

- (void) train
{
    [self stateChange:PET_STATE_TRAINING];
}

-(void) stopTraining
{
    [self stateChange:PET_STATE_RESTING];
}

-(void) update
{
    switch (self.petState)
    {
        default:
        case PET_STATE_RESTING:
            [self doRest];
            break;
        case PET_STATE_TRAINING:
            [self doTrain];
            break;
        case PET_STATE_EATING:
            [self doEat];
            break;
        case PET_STATE_TIRED:
            break;
    }
}

#pragma mark - Private Methods

- (void) doTrain
{
    if([self.energy floatValue] > 0.0f)
    {
        [self addToEnergy:[[NSNumber alloc] initWithFloat:ENERGY_MULTIPLIER_TRAIN]];
        [self plusExpe:[[NSNumber alloc] initWithInt:EXPERIENCE_MULTIPLIER_BY_TRAIN]];
    }
}

- (void) doRest
{
    if([self.energy floatValue] > 0.0f)
    {
        [self addToEnergy:[[NSNumber alloc] initWithFloat:ENERGY_MULTIPLIER_REST]];
    }
}

-(void) doEat
{
    if([self.energy floatValue] < 100.0f)
    {
        [self addToEnergy:[[NSNumber alloc] initWithFloat:([self.eatingFood.RechargeAmmount floatValue] * ENERGY_MULTIPLIER_EAT)]];
    }
}

- (void) addToEnergy:(NSNumber*) energyDelta
{
    float energyValue = [self.energy floatValue] + [energyDelta floatValue];
    energyValue =   (energyValue < 0.0f) ? 0.0f :
                    (energyValue > 100.0f) ? 100.0f : energyValue;
    
    _energy = [[NSNumber alloc] initWithFloat:(energyValue)];
    
    //if finished eating
    if( energyValue == 100.0f)
    {
        [self stateChange:PET_STATE_RESTING];
        [self.stateTimer safeInvalidate];
        [self setEatingFood:nil];
    }
    if( energyValue == 0.0f)
    {
        [self stateChange:PET_STATE_TIRED];
        [self.stateTimer safeInvalidate];
    }
    
    if(energyValue < 20.0f)
    {
        [NotificationManager sendLocalNotificationWithGochi:self];
    }
    if(self.delegate != nil)
    {
        [self.delegate gochiEnergyModified];
    }
    
    
}

- (void) stateChange:(PetStateIdentifier)petState
{
    PetStateIdentifier previousState = self.petState;
    self.petState = petState;
    if(self.delegate != nil)
    {
        [self.delegate gochiChangedFromState:previousState toState:petState];
    }
}

-(void)dealloc
{
    if(self.stateTimer != nil)
    {
        [self.stateTimer safeInvalidate];
    }
}

- (void) plusExpe: (NSNumber* ) expDelta
{
    const int maxExpInLevel = [self.maxExperience intValue];
    _experience = [[NSNumber alloc] initWithInt:([_experience intValue] + [expDelta intValue])];
    
    if([_experience intValue] >= maxExpInLevel)
    {
        _experience = [[NSNumber alloc] initWithInt:([_experience intValue] - maxExpInLevel)];
        [self levelUp];
    }
}

- (void) levelUp
{
    _level = [[NSNumber alloc] initWithInt:([self.level intValue] + 1)];
    if(self.delegate != nil)
    {
        _maxExperience = [[NSNumber alloc] initWithInt:([self.level intValue] * [self.level intValue] * 100)];
        [self.delegate gochiLevelUp];
        [self saveGochi];
        [NotificationManager pushLevelupGochiNotification:self];
    }
}

#pragma mark - NSCoding protocol
/*
 //Pet properties
 @property(strong, nonatomic) NSString* name;
 @property(assign, nonatomic) PetIdentifier petType;
 @property(assign, nonatomic) PetStateIdentifier petState;
 
 //Attributes
 @property(strong, nonatomic, readonly) NSNumber* energy;
 @property(strong, nonatomic, readonly) NSNumber* experience;
 @property(strong, nonatomic, readonly) NSNumber* maxExperience;
 @property(strong, nonatomic, readonly) NSNumber* level;
 @property(strong, nonatomic, readonly) NSString* code;
 @property(strong, nonatomic, readonly) CLLocation* location;
 */

#define KEY_NAME            @"KeyName"
#define KEY_TYPE            @"Keytype"
#define KEY_ENERGY          @"KeyEnergy"
#define KEY_EXPERIENCE      @"KeyExperience"
#define KEY_MAX_EXPERIENCE  @"KeyMaxExperience"
#define KEY_LEVEL           @"KeyLevel"
#define KEY_CODE            @"KeyCode"
#define KEY_LOCATION        @"KeyLocation"

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        [self setName:[aDecoder decodeObjectForKey:KEY_NAME]];
        _energy = [aDecoder decodeObjectForKey:KEY_ENERGY];
        _experience = [aDecoder decodeObjectForKey:KEY_EXPERIENCE];
        _maxExperience = [aDecoder decodeObjectForKey:KEY_MAX_EXPERIENCE];
        _level = [aDecoder decodeObjectForKey:KEY_LEVEL];
        _code = [aDecoder decodeObjectForKey:KEY_CODE];
        _location = [aDecoder decodeObjectForKey:KEY_LOCATION];
        [self setPetType:[[aDecoder decodeObjectForKey:KEY_TYPE] intValue]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:KEY_NAME];
    [aCoder encodeObject:self.energy forKey:KEY_ENERGY];
    [aCoder encodeObject:self.experience forKey:KEY_EXPERIENCE];
    [aCoder encodeObject:self.maxExperience forKey:KEY_MAX_EXPERIENCE];
    [aCoder encodeObject:self.level forKey:KEY_LEVEL];
    [aCoder encodeObject:self.code forKey:KEY_CODE];
    [aCoder encodeObject:self.location forKey:KEY_LOCATION];
    [aCoder encodeObject:[[NSNumber alloc] initWithInt:self.petType] forKey:KEY_TYPE];
}

#undef KEY_NAME
#undef KEY_NAME
#undef KEY_TYPE
#undef KEY_ENERGY
#undef KEY_EXPERIENCE
#undef KEY_MAX_EXPERIENCE
#undef KEY_LEVEL
#undef KEY_CODE
#undef KEY_LOCATION

#pragma mark - Save gochi

- (void) saveGochi
{
    [self saveGochiOnServer];
    [self saveGochiOnDisk];
}

- (void) saveGochiOnDisk
{
    
}
- (void) saveGochiOnServer
{
    //Send info to server
    SuccessBlock success = ^(NSURLSessionDataTask* task, id responseObject)
    {
        NSDictionary* serverResponse = (NSDictionary*)responseObject;
        NSString* status = serverResponse[@"status"];
        if(![status isEqualToString:@"ok"])
        {
            NSLog(@"Gochi saved on server correctly");
        }
        else
        {
            NSLog(@"Gochi have not been saved");
        }
    };
    
    [[NetworkRequestsHelper sharedInstance] postGochiOnServer:self successBlock:success failureBlock:nil];
}


#pragma mark - Validation Methods

- (BOOL) isOwnGochi
{
    return [self.code isEqualToString:OWN_GOCHI_ID];
}

#pragma mark - Network utils

- (NSDictionary*) dictionaryByGochi
{
    NSMutableDictionary* answer = [[NSMutableDictionary alloc] init];
    answer[@"code"] = self.code;
    answer[@"name"] = self.name;
    answer[@"energy"] = self.energy;
    answer[@"level"] = self.level;
    answer[@"experience"] = self.experience;
    answer[@"pet_type"] = [[NSNumber alloc] initWithInt:self.petType];
    
    CLLocation* newLocation = [[LocationHelper sharedInstance] lastLocation];
    if(newLocation !=nil)
    {
        _location = newLocation;
    }
    if(self.location != nil)
    {
        answer[@"position_lat"] = [[NSNumber alloc] initWithDouble:self.location.coordinate.latitude];
        answer[@"position_lon"] = [[NSNumber alloc] initWithDouble:self.location.coordinate.longitude];
    }
    return answer;
}

-(instancetype) initWithDictionary:(NSDictionary*) dictionary
{
    self = [super init];
    if(self)
    {
        _energy = dictionary[@"energy"];
        _level = dictionary[@"level"];
    	_experience = dictionary[@"experience"];
    	self.name = (NSString*) dictionary[@"name"];
        self.petType = [dictionary[@"pet_type"] intValue];
        _maxExperience = [[NSNumber alloc] initWithInt:([self.level intValue] * [self.level intValue] * 100)];
        _code = (NSString*) dictionary[@"code"];
        NSNumber* posLat = [dictionary objectForKey:@"position_lat"];
        NSNumber* posLon = [dictionary objectForKey:@"position_lon"];
        if(posLat && posLon)
        {
            _location = [[CLLocation alloc] initWithLatitude:[posLat doubleValue] longitude:[posLon doubleValue]];
        }
        
        //Add notification observer
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateGochiLocation) name:MAP_LOCATION_UPDATED_NOTIFICATION object:nil];
    }
    return self;
}

#pragma mark - location

-(void) updateGochiLocation
{
    _location = [[LocationHelper sharedInstance] lastLocation];
    [self saveGochi];
}


#pragma mark - Sorting

- (NSComparisonResult) compare:(Gochi*) gochi
{
    return [self.level compare:gochi.level];
}

- (NSString *)description
{
    NSString* format = @"Name: %@\n Level: %@\n Location :%@\n";
    NSString* answer = [NSString stringWithFormat:format, self.name, self.level, self.location];
    
    return answer;
}

@end
