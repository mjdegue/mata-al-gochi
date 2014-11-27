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
    switch (self.petState) {
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
    }
}

#pragma mark - Network utils

- (NSDictionary*) dictionaryByGochi
{
    NSMutableDictionary* answer = [[NSMutableDictionary alloc] init];
    answer[@"code"] = OWN_GOCHI_ID;
    answer[@"name"] = self.name;
    answer[@"energy"] = self.energy;
    answer[@"level"] = self.level;
    answer[@"experience"] = self.experience;
    answer[@"tipo"] = [[NSNumber alloc] initWithInt:self.petType]; //@TODO: Check this
    return answer;
}

-(instancetype) initWithDictionary:(NSDictionary*) dictionary
{
    self = [super init];
    _energy = dictionary[@"energy"];
    _level = dictionary[@"level"];
    _experience = dictionary[@"experience"];
    self.name = (NSString*) dictionary[@"name"];
    self.petType = PET_DEER; //@TODO: Replace this for real values
    _maxExperience = [[NSNumber alloc] initWithInt:([self.level intValue] * [self.level intValue] * 100)];
    return self;
}

@end
