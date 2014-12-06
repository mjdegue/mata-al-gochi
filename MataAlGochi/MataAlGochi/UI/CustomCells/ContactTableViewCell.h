//
//  ContactTableViewCell.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/6/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString* ContactTableViewCellReuseStringIdentifier = @"CONTACT_TABLE_VIEW_CELL_IDENTIFIER";
static NSString* ContactTableViewCellNibString = @"ContactTableViewCell";

@protocol ContactTableViewCellDelegate <NSObject>

- (void) didStartCallToPhone:(NSString*) phone;
- (void) didStartMailSendingToMail:(NSString*) mail;

@end

@interface ContactTableViewCell : UITableViewCell
@property(weak, nonatomic) id<ContactTableViewCellDelegate> delegate;

- (void) fillWithDictionary:(NSDictionary*) dictionary;
@end
