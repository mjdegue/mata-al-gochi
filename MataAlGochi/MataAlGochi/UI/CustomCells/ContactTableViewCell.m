//
//  ContactTableViewCell.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/6/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "ContactsManager.h"

@interface ContactTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblMail;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UILabel *lblCompany;
@property (strong, nonatomic) IBOutlet UIButton *btnMailButton;
@property (strong, nonatomic) IBOutlet UIButton *btnPhoneButton;
@end

@implementation ContactTableViewCell


- (void) fillWithDictionary:(NSDictionary*) dictionary
{
    NSString* name = dictionary[kKeyNameValue];
    NSString* lastName = dictionary[kKeyLastNameValue];
    
    NSString* fullName;
    if(name && lastName)
    {
         fullName = [NSString stringWithFormat:@"%@, %@", lastName, name];
        
    }
    else
    {
        fullName = name ? name : lastName;
    }
    [self.lblName setText:fullName];
    
    NSArray* mails = dictionary[kKeyMailsValue];
    if(mails && [mails count] > 0)
    {
        [self.btnMailButton setEnabled:YES];
        [self.btnMailButton setAlpha:100];
        [self.lblMail setText:[mails objectAtIndex:0]];
    }
    else
    {
        
        [self.lblMail setText:@"Unabailable Mail"];
        [self.btnMailButton setAlpha:0];
        [self.btnMailButton setEnabled:NO];
    }
    
    NSArray* phones = dictionary[kKeyPhonesValue];
    if(phones && [phones count] > 0)
    {
        [self.btnPhoneButton setEnabled:YES];
        [self.btnPhoneButton setAlpha:100];
        [self.lblPhone setText:[phones objectAtIndex:0]];
    }
    else
    {
        [self.lblPhone setText:@"Unabailable Phone"];
        [self.btnPhoneButton setAlpha:0];
        [self.btnPhoneButton setEnabled:NO];
    }
    
    NSString* company = dictionary[kKeyCompanyValue];
    if(company)
    {
        [self.lblCompany setText:company];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didPressMailButton:(id)sender
{
    if(self.delegate)
    {
        [self.delegate didStartMailSendingToMail:[self.lblMail text]];
    }
}

- (IBAction)didPressPhoneButton:(id)sender
{
    if(self.delegate)
    {
        [self.delegate didStartCallToPhone:[self.lblPhone text]];
    }
}

@end
