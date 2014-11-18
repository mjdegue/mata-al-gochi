//
//  TamagochiNameSelectionViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 11/18/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "TamagochiNameSelectionViewController.h"

@interface TamagochiNameSelectionViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtGochisName;

@end

@implementation TamagochiNameSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.txtGochisName.delegate = self;
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
@end
