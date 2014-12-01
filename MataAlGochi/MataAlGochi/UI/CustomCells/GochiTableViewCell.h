//
//  GochiTableViewCell.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/1/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gochi.h"

static NSString* GochiTableViewCellReuseStringIdentifier = @"GOCHI_TABLE_VIEW_CELL_IDENTIFIER";
static NSString* GochiTableViewCellNibString = @"GochiTableViewCell";

@interface GochiTableViewCell : UITableViewCell

- (void)fillWithGochi:(Gochi *)gochi shouldBright:(BOOL) shouldBright;

@end
