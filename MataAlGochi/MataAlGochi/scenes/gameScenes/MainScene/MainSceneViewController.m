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

//Local defines
#define MAIL_STRING_WITH_FORMAT @"Buenas! Soy %@, cómo va? Quería comentarte que estuve usando la App Mata al Gochi para comerme todo y está genial. Bajatela YA!! Saludos!"
#define MAIL_SUBJECT @"Que App mas copada que tengo para vos";

@interface MainSceneViewController ()

//Properties
@property(nonatomic,strong) Gochi* activeGochi;
@property(nonatomic,strong) Food* activeFood;
@property(nonatomic,strong) Game* gameInstance;
@property(nonatomic,strong) MFMailComposeViewController* mailComposer;

//IBOutlets
@property (strong, nonatomic) IBOutlet UIImageView *imgGochiImage;
@property (strong, nonatomic) IBOutlet UIImageView *imgFood;
@property (strong, nonatomic) IBOutlet UIView *mouthViewCollider;
@property (strong, nonatomic) IBOutlet UIProgressView *barFoodStatusBar;
@property (strong, nonatomic) IBOutlet UIButton *btnTrainingButton;

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
}

-(void)viewWillAppear:(BOOL)animated
{
    //Game instance setup
    [self setGameInstance:[Game GetInstance]];
    
    //Gochi methods
    [self setActiveGochi:[self.gameInstance activeGochi]];
    [self.activeGochi setDelegate:self];
    [self setTitle:[self.activeGochi name]];
    [self refreshPetImage];
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
- (void) refreshPetImage
{
    [self.imgGochiImage setImage:[ImageLoader loadPetImageByType:[[self activeGochi] petType]]];
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
}

- (void) gochiLevelUp
{
    NSString* messageTittle = [[NSString alloc] initWithFormat:@"%@ leveled up", [self.activeGochi name]];
    NSString* messageBody = [[NSString alloc] initWithFormat:@"Congratulations! %@ reached level %@", [self.activeGochi name], [self.activeGochi level]];
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
    [self.imgGochiImage setAnimationImages:[ImageLoader loadPetAnimationByPet:(self.activeGochi.petType) andPetState:PET_STATE_TIRED]];
    [self.imgGochiImage setAnimationDuration:2.0f];
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

@end