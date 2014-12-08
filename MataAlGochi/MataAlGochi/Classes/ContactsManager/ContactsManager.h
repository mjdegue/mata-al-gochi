//
//  ContactsManager.h
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/5/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

//mascs from here:
#define kOptionNameValue        0x00000001
#define kOptionLastNameValue    0x00000002
#define kOptionPhonesValue      0x00000004
#define kOptionMailsValue       0x00000008
#define kOptionCompanyValue     0x00000010

#define kOptionFullContact      kOptionNameValue | \
                                kOptionLastNameValue | \
                                kOptionPhonesValue | \
                                kOptionMailsValue | \
                                kOptionCompanyValue


#define kKeyNameValue           @"AB_NAME_VALUE"
#define kKeyLastNameValue       @"AB_LASTNAME_VALUE"
#define kKeyPhonesValue         @"AB_PHONE_VALUE"
#define kKeyMailsValue          @"AB_MAIL_VALUE"
#define kKeyCompanyValue        @"AB_COMPANY_VALUE"

@interface ContactsManager : NSObject

//Properties
@property (assign, nonatomic) ABAddressBookRef addressBook;

//specific methods
- (void) initializeAddressBook;

//methods
- (void) askAuthorizationToUser;
- (ABAuthorizationStatus) authorizationStatus;
- (NSArray*) arrayOfPeopleWithOptions:(int) options;


//singleton
+ (instancetype) sharedInstance;
+ (void) destroyInstance;
@end
