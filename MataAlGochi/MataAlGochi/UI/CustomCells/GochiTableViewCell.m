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
@property (strong, nonatomic) IBOutlet UILabel *lblGochiName;
@property (strong, nonatomic) IBOutlet UILabel *lblGochiLevel;
@property (strong, nonatomic) IBOutlet UIImageView *imgGochiImage;

@end


@implementation GochiTableViewCell


//Constructor
- (void)fillWithGochi:(Gochi *)gochi shouldBright:(BOOL) shouldBright
{
    [self.lblGochiName setText:gochi.name];
    [self.lblGochiLevel setText:[NSString stringWithFormat:@"Level: %@", gochi.level]];
    
    [self.imgGochiImage setImage:[ImageLoader loadPetImageByType:gochi.petType]];
    if(shouldBright)
    {
        [self setBackgroundColor:[UIColor orangeColor]];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
