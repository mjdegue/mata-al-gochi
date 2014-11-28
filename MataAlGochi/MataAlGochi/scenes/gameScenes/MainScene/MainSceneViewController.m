//
//  MainSceneViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "MainSceneViewController.h"
#import "ImageLoader.h"
#import "Game.h"
#import "Gochi.h"
#import "NetworkRequestsHelper.h"
#import "NotificationConstants.h"
#import "NotificationManager.h"

//Local defines
#define MAIL_STRING_WITH_FORMAT @"Buenas! Soy %@, cómo va? Quería comentarte que estuve usando la App Mata al Gochi para comerme todo y está genial. Bajatela YA!! Saludos!"
#define MAIL_SUBJECT @"Que App mas copada que tengo para vos";

@interface MainSceneViewController ()

//Properties
@property(nonatomic,strong) Gochi* activeGochi;
@property(nonatomic,strong) Food* activeFood;
@property(nonatomic,strong) Game* gameInstance;
@property(nonatomic,strong) MFMailComposeViewController* mailComposer;
@property(nonatomic,assign) CGPoint imgOriginalPosition;
@property(nonatomic,assign) CGRect imgOriginalFrame;

//IBOutlets
@property (strong, nonatomic) IBOutlet UIImageView *imgGochiImage;
@property (strong, nonatomic) IBOutlet UIImageView *imgFood;
@property (strong, nonatomic) IBOutlet UIView *mouthViewCollider;
@property (strong, nonatomic) IBOutlet UIProgressView *barFoodStatusBar;
@property (strong, nonatomic) IBOutlet UIButton *btnTrainingButton;
@property (strong, nonatomic) IBOutlet UILabel *lblExperience;
@property (strong, nonatomic) IBOutlet UILabel *lblLevel;
@property (strong, nonatomic) IBOutlet UILabel *lblEnemy;

//Gestures
@property(nonatomic,strong) UITapGestureRecognizer* gestTapGest;

@end

@implementation MainSceneViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setGameInstance:[Game GetInstance]];
    
    return self;
}

#pragma mark - ViewController specific
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Modify the UIBar
    UIBarButtonItem* optionsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(goToFeedScreen:)];
    UIBarButtonItem* mailButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mail_image"]  style:UIBarButtonItemStyleDone target:self action:@selector(prepareMailToSend)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:optionsButton, mailButton, nil];
    self.navigationItem.rightBarButtonItem = optionsButton;
    
    //Gesture setup
    self.gestTapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    self.gestTapGest.delegate = self;
    [self.view addGestureRecognizer:self.gestTapGest];
    
    //Food image setup
    self.imgOriginalPosition = [self.imgFood center];
    self.imgOriginalFrame = [self.imgFood frame];
}

-(void)viewWillAppear:(BOOL)animated
{
    //Game instance setup
    [self setGameInstance:[Game GetInstance]];
    
    //Gochi methods
    [self setActiveGochi:[self.gameInstance activeGochi]];
    [self.activeGochi setDelegate:self];
    [self setTitle:[self.activeGochi name]];
    [self loadImageInAppear];
    [self updateLevelAndExperience];
    //Set food image
    [self.imgFood setCenter:self.imgOriginalPosition];
    [self.imgFood setFrame:self.imgOriginalFrame];
    
    //Set enemy label
    [self.lblEnemy setText:@""];
    
    //Add observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveEnemyInfo:) name:NOTIFICATION_FIGHTING_GOCHI_GOT_INFO object:nil];
    
    //Suscrube to parse
    [NotificationManager suscribeToGochisFightChannel];
}

- (void) viewWillDisappear:(BOOL)animated
{
    //[NotificationManager unsuscribeToGochisFightChannel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void) goToFeedScreen: (id) sender
{
    FeedSceneViewController* feedScene = [[FeedSceneViewController alloc] initWithNibName:@"FeedSceneViewController" bundle:nil];
    
    feedScene.foodDelegate = self;
    
    [self.navigationController pushViewController:feedScene animated:true];
}

#pragma mark - Visualization
- (void) loadImageInAppear
{
    if(self.activeGochi.petState == PET_STATE_TIRED)
    {
        [self.imgGochiImage setImage:[[ImageLoader loadPetAnimationByPet:self.activeGochi.petType andPetState:PET_STATE_TIRED] lastObject]];
    }
    else if(self.activeGochi.petState == PET_STATE_RESTING)
    {
        [self.imgGochiImage setImage:[ImageLoader loadPetImageByType:self.activeGochi.petType]];
    }
}

- (void) updateLevelAndExperience
{
    NSString* levelLabelText = [[NSString alloc] initWithFormat:@"Level: %@", self.activeGochi.level];
    NSString* experienceLabelText = [[NSString alloc] initWithFormat:@"Experience: %@ / %@", self.activeGochi.experience, self.activeGochi.maxExperience];
    [self.lblLevel setText:levelLabelText];
    [self.lblExperience setText:experienceLabelText];
}

#pragma mark - FoodDelegate
- (void) prepareGochisFood: (Food*) food
{
    self.activeFood = food;
    [self.imgFood setImage:[ImageLoader loadFoodImageByType:[food FoodType]]];
}


#pragma mark - Gestures

- (void) handleTap:(UITapGestureRecognizer *)recognizer
{
    static BOOL isAnimationInProgress = NO;
    if((self.activeFood != nil) && !isAnimationInProgress)
    {
        //Animate here
        CGPoint point = [recognizer locationInView:self.view];
        
        [UIView animateWithDuration:1.0f
                              delay:0.2f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^
                                    {
                                        isAnimationInProgress = YES;
                                        [self.imgFood setCenter:point];
                                    }
                         completion:^(BOOL finished)
                                    {
                                        isAnimationInProgress = NO;
                                        if(finished)
                                        {
                                            BOOL shouldFeedGochi = [self shouldFeedGochi];
                                            if(shouldFeedGochi)
                                            {
                                                [self.activeGochi feedWith:self.activeFood];
                                            }
                                        }
                                    }];
    }
}

#pragma mark - Refactor next

//where should be this

-(BOOL) shouldFeedGochi
{
    BOOL answer = NO;
    
    if (CGRectContainsPoint(self.mouthViewCollider.frame, self.imgFood.center) )
    {
        answer = YES;
    }
    return answer;
 }

- (void) startFoodDecrease
{
    
    [UIView animateWithDuration:4.0f
                          delay:0.2f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
                                {
                                    CGRect futureFrame = [self.imgFood frame];
                                    CGPoint center = [self.imgFood center];
                                    futureFrame.size.height = 0;
                                    futureFrame.size.width = 0;
                                    [self.imgFood setFrame:futureFrame];
                                    [self.imgFood setCenter:center];
                                    [self.barFoodStatusBar
                                        setProgress: ([self.activeGochi.energy floatValue] / 100)
                                            animated:YES];
                                }
                     completion:^(BOOL finished)
                               {
                                   
                               }];
    [self.imgGochiImage setAnimationImages:
        [ImageLoader loadPetAnimationByPet:[self.activeGochi petType]
                               andPetState:PET_STATE_EATING]];
        
    [self.imgGochiImage startAnimating];
}

- (void) finishEating
{
    [self.imgGochiImage stopAnimating];
    [self.imgFood setImage:nil];
    self.activeFood = nil;
}

- (IBAction)startTraining:(id)sender
{
    if(self.activeGochi.petState != PET_STATE_TRAINING)
    {
        [self.activeGochi train];
    }
    else
    {
        [self.activeGochi stopTraining];
    }
    [self updateTrainingButton];
}

-(void) updateTrainingButton
{
    if([self.activeGochi.energy floatValue] == 0.0f)
    {
        [self.btnTrainingButton setEnabled:NO];
        [self.btnTrainingButton setTitle:@"Start Training" forState:UIControlStateDisabled];
    }
    else
    {
        [self.btnTrainingButton setEnabled:YES];
        if(self.activeGochi.petState == PET_STATE_TRAINING)
        {
            [self.btnTrainingButton setTitle:@"Stop Training" forState:UIControlStateNormal];
        }
        else
        {
            [self.btnTrainingButton setTitle:@"Start Training" forState:UIControlStateNormal];
        }
    }
}

#pragma mark - GochiDelegate

- (void) gochiChangedFromState:(PetStateIdentifier) previousState toState:(PetStateIdentifier) newState
{
    if(previousState == PET_STATE_EATING)
    {
        [self finishEating];
    }
    switch (newState)
    {
        default:
        case PET_STATE_RESTING:
            [self startGochiRest];
            break;
        case PET_STATE_TRAINING:
            [self startGochiTrain];
            break;
        case PET_STATE_EATING:
            [self startGochiEat];
            break;
        case PET_STATE_TIRED:
            [self startGochiTired];
            break;
    }
}

- (void) gochiEnergyModified
{
    float progress = [self.activeGochi.energy floatValue] / 100.0f;
    [self.barFoodStatusBar setProgress:progress animated:YES];
    [self updateTrainingButton];
    [self updateLevelAndExperience];
}

- (void) gochiLevelUp
{
    NSString* messageTittle = [[NSString alloc] initWithFormat:@"%@ leveled up", [self.activeGochi name]];
    NSString* messageBody = [[NSString alloc] initWithFormat:@"Congratulations! %@ reached level %@", [self.activeGochi name], [self.activeGochi level]];
    
    //Send info to server
    SuccessBlock success = ^(NSURLSessionDataTask* task, id responseObject)
    {
        NSDictionary* serverResponse = (NSDictionary*)responseObject;
        NSString* status = serverResponse[@"status"];
        if(![status isEqualToString:@"ok"])
        {
            [[[UIAlertView alloc] initWithTitle:@"Hubo algun problema" message:@"Hubo algun problema" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
    };

    [[NetworkRequestsHelper sharedInstance] postGochiOnServer:self.activeGochi successBlock:success failureBlock:nil];
    
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:messageTittle message:messageBody delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - Gochi Activities
- (void) startGochiRest
{
    [self.imgGochiImage stopAnimating];
    [self.imgGochiImage setImage:[ImageLoader loadPetImageByType:(self.activeGochi.petType)]];
}

- (void) startGochiTrain
{
    [self.imgGochiImage setAnimationImages:[ImageLoader loadPetAnimationByPet:(self.activeGochi.petType) andPetState:PET_STATE_TRAINING]];
    [self.imgGochiImage startAnimating];
}

- (void) startGochiEat
{
    [self.imgGochiImage setAnimationImages:[ImageLoader loadPetAnimationByPet:(self.activeGochi.petType) andPetState:PET_STATE_EATING]];
    [self.imgGochiImage startAnimating];
    [self startFoodDecrease];
}

- (void) startGochiTired
{
    //Set animation:
    NSArray* animationArray = [ImageLoader loadPetAnimationByPet:(self.activeGochi.petType) andPetState:PET_STATE_TIRED];
    [self.imgGochiImage setAnimationImages:animationArray];
    [self.imgGochiImage setAnimationDuration:2.0f];
    [self.imgGochiImage setAnimationRepeatCount:1];
    
    //Set post-animation image
    [self.imgGochiImage setImage:[animationArray lastObject]];
    
    //Start image
    [self.imgGochiImage startAnimating];
}

#pragma mark - Mails
-(void) prepareMailToSend
{
    //NSString* mailBody = [[NSString alloc] initWithFormat:MAIL_STRING_WITH_FORMAT, self.a];
    NSString* mailBody = [[NSString alloc] initWithFormat:MAIL_STRING_WITH_FORMAT, self.activeGochi.name];
    NSString* mailSubject = MAIL_SUBJECT;
    self.mailComposer = [[MFMailComposeViewController alloc]init];
    self.mailComposer.mailComposeDelegate = self;
    [self.mailComposer setSubject:mailSubject];
    [self.mailComposer setMessageBody:mailBody isHTML:NO];
    [self presentViewController:self.mailComposer animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *alert;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            alert = [[UIAlertView alloc] initWithTitle:@"Cancel by user" message:@"You canceled the mail" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            break;
        case MFMailComposeResultSaved:
            alert = [[UIAlertView alloc] initWithTitle:@"Draft Saved" message:@"Composed Mail is saved in draft." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            break;
        case MFMailComposeResultSent:
            alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have successfully sent email." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            break;
        case MFMailComposeResultFailed:
            alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Sorry! Failed to send." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) didReceiveEnemyInfo:(NSNotification* ) sender
{
    NSDictionary* dictionary = (NSDictionary*)sender.object;
    NSString* name = dictionary[@"name"];
    NSString* level = dictionary[@"level"];
    
    [self.lblEnemy setText:[[NSString alloc] initWithFormat:@"Your arch-enemy %@ is now level %@", name, level]];
}
- (IBAction)pushFakeNotification:(id)sender
{
    [NotificationManager pushLevelupGochiNotification:self.activeGochi];
}

@end