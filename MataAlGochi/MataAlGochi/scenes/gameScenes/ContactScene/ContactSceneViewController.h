//
//  ContactSceneViewController.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/5/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactTableViewCell.h"
#import <MessageUI/MessageUI.h>

@interface ContactSceneViewController : UIViewController<UITableViewDataSource, ContactTableViewCellDelegate, MFMailComposeViewControllerDelegate>

@end
