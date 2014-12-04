//
//  GochiTableViewCell.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "GochiTableViewCell.h"
#import "ImageLoader.h"

@interface GochiTableViewCell()

//properties
@property (strong, nonatomic) Gochi* gochi;

//IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *lblGochiName;
@property (strong, nonatomic) IBOutlet UILabel *lblGochiLevel;
@property (strong, nonatomic) IBOutlet UIButton *btnGochiImage;
@property (strong, nonatomic) IBOutlet UIButton *btnGochiLocation;

@end


@implementation GochiTableViewCell


//Constructor
- (void)fillWithGochi:(Gochi *)gochi shouldBright:(BOOL) shouldBright
{
    self.gochi = gochi;
    [self.lblGochiName setText:gochi.name];
    [self.lblGochiLevel setText:[NSString stringWithFormat:@"Level: %@", gochi.level]];
    
    [self.btnGochiImage setBackgroundImage:[ImageLoader loadPetImageByType:gochi.petType] forState:UIControlStateNormal];
    
    if(shouldBright)
    {
        [self setBackgroundColor:[UIColor orangeColor]];
    }
    else
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    
    if( gochi.location!= nil)
    {
        [self.btnGochiLocation setHidden:NO];
        [self.btnGochiLocation setEnabled:YES];
        [self.btnGochiLocation setBackgroundImage:[ImageLoader loadButtonImage:BTN_MAP] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnGochiLocation setHidden:YES];
        [self.btnGochiLocation setEnabled:NO];
    }
    
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didAskGochiInMap:(id)sender
{
    if(self.delegate != nil)
    {
        [self.delegate didSelectGochiInMap:self.gochi];
    }
}

- (IBAction)wantToVisitGochi:(id)sender
{
    NSString* urlFormat = @"tamagotchi://pet/%@";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:urlFormat, self.gochi.code]]];

}

@end
