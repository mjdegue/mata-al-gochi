//
//  TamagochiNameSelectionViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "TamagochiNameSelectionViewController.h"
#import "TamagochiAssetSelectorViewController.h"
#import "CreationFlow.h"

@interface TamagochiNameSelectionViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtGochisName;
@property (strong, nonatomic) IBOutlet UILabel *lblNotificationLabel;

@end

@implementation TamagochiNameSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.txtGochisName.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.lblNotificationLabel setText:@"Your gochi's name is invalid."];
    [self.lblNotificationLabel setTextColor:[UIColor redColor]];
    [self.lblNotificationLabel setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continueBtnPressed:(id)sender
{
    self.sGochisName = [[NSString alloc] initWithString:[self.txtGochisName text]];
    [self.view endEditing:YES];
    
    if(![self validateForm])
    {
        [self.lblNotificationLabel setHidden:NO];
        return;
    }
    else
    {
        [self.lblNotificationLabel setHidden:YES];
    }
    
    CreationFlow* creationFlow = [CreationFlow GetInstance];
    [creationFlow setGochisName:[self sGochisName]];
    
    TamagochiAssetSelectorViewController* assetSelectionView = [[TamagochiAssetSelectorViewController alloc] initWithNibName:@"TamagochiAssetSelectorViewController" bundle:nil];
    
    [self.navigationController pushViewController:assetSelectionView animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) validateForm
{
    if([self.txtGochisName.text length] < 5)
        return NO;
    
    return YES;
}
@end
