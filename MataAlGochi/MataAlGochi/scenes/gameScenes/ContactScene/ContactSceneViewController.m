//
//  ContactSceneViewController.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/5/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "ContactSceneViewController.h"
#import "ContactsManager.h"

@interface ContactSceneViewController ()

//Properties
@property (strong, nonatomic) NSArray* contactsArray;
@property(nonatomic,strong) MFMailComposeViewController* mailComposer;

//IBOutlets
@property (strong, nonatomic) IBOutlet UITableView *tblContactTable;

@end

@implementation ContactSceneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    ABAuthorizationStatus authStatus = [[ContactsManager sharedInstance] authorizationStatus];
    if(authStatus == kABAuthorizationStatusAuthorized ||
        authStatus == kABAuthorizationStatusRestricted)
    {
        [[ContactsManager sharedInstance] initializeAddressBook];
        self.contactsArray = [[ContactsManager sharedInstance] arrayOfPeopleWithOptions:(kOptionFullContact)];
    }
    else
    {
        NSLog(@"Authorization have not been granthed");
    }
    
    //set up table info
    self.title = @"Contact list";
}

- (void) viewWillAppear:(BOOL)animated
{
    //Set table info:
    self.tblContactTable.dataSource = self;
    [self.tblContactTable registerNib:[UINib nibWithNibName:ContactTableViewCellNibString bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ContactTableViewCellNibString];

    [self.tblContactTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) reloadContactsData
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactTableViewCell* contactCell = [tableView dequeueReusableCellWithIdentifier:ContactTableViewCellNibString];
    
    if(contactCell == nil)
    {
        contactCell = [[ContactTableViewCell alloc] init];
    }
    
    //Fill cell data
    NSDictionary* dic = [self.contactsArray objectAtIndex:indexPath.row];
    [contactCell fillWithDictionary:dic];
    contactCell.delegate = self;
    
    return contactCell;
}

- (void)didStartCallToPhone:(NSString *)phone
{
    NSString* phoneURL = [NSString stringWithFormat:@"tel:%@", phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURL]];
}

//Local defines
#define MAIL_STRING_WITH_FORMAT @"Buenas! Como va? Quería comentarte que estuve usando la App Mata al Gochi para comerme todo y está genial. Bajatela YA!! Saludos!"
#define MAIL_SUBJECT @"Que App mas copada que tengo para vos";

- (void)didStartMailSendingToMail:(NSString *)mail
{
    NSString* mailBody = [[NSString alloc] initWithFormat:MAIL_STRING_WITH_FORMAT];
    NSString* mailSubject = MAIL_SUBJECT;
    self.mailComposer = [[MFMailComposeViewController alloc]init];
    self.mailComposer.mailComposeDelegate = self;
    [self.mailComposer setToRecipients:[[NSArray alloc]initWithObjects:mail, nil]];
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
