//
//  ContactsManager.m
//  MataAlGochi
//
//  Created by Maximiliano Joaquin Degue on 12/5/14.
//  Copyright (c) 2014 Maximiliano Joaquin Degue. All rights reserved.
//

#import "ContactsManager.h"

@interface ContactsManager ()
@end

@implementation ContactsManager

- (void) initializeAddressBook
{
    self.addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
}

-(void) askAuthorizationToUser
{
    if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
    {
        ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     if(error)
                                                     {
                                                         NSLog(@"Loggin error: %@", error);
                                                     }
                                                 });
    }
}

-(ABAuthorizationStatus) authorizationStatus
{
    return ABAddressBookGetAuthorizationStatus();
}


//retreive info
- (NSArray*) arrayOfPeopleWithOptions:(int) options
{
    NSMutableArray* peopleArray = [[NSMutableArray alloc]init];
    CFArrayRef all = ABAddressBookCopyArrayOfAllPeople(self.addressBook);
    
    CFIndex index = ABAddressBookGetPersonCount(self.addressBook);
    for(int i = 0; i < index; ++i)
    {
        NSMutableDictionary* person = [[NSMutableDictionary alloc] init];
        ABRecordRef ref = CFArrayGetValueAtIndex(all, i);
        
        //Add first name
        if( options & kOptionNameValue)
        {
            NSString* firstName = (__bridge NSString*) ABRecordCopyValue(ref, kABPersonFirstNameProperty);
            person[kKeyNameValue] = firstName ? firstName : @"";
        }
        
        if( options & kOptionLastNameValue)
        {
            NSString* lastName = (__bridge NSString*) ABRecordCopyValue(ref, kABPersonLastNameProperty);
            person[kKeyNameValue] = lastName ? lastName : @"";
        }
        
        if( options & kOptionMailsValue)
        {
            ABMultiValueRef mailProperty = ABRecordCopyValue(ref, kABPersonEmailProperty);
            NSArray* mails = (__bridge NSArray*) ABMultiValueCopyArrayOfAllValues(mailProperty);
            person[kKeyMailsValue] = mails ? mails : [[NSArray alloc] init];
        }
        
        if( options & kOptionPhonesValue)
        {
            ABMultiValueRef phoneProperty = ABRecordCopyValue(ref, kABPersonPhoneProperty);
            NSArray* phones = (__bridge NSArray*) ABMultiValueCopyArrayOfAllValues(phoneProperty);
            person[kKeyPhonesValue] = phones ? phones : [[NSArray alloc] init];
        }
        
        if( options & kOptionCompanyValue)
        {
            NSString* company = (__bridge NSString*) ABRecordCopyValue(ref, kABPersonOrganizationProperty);
            person[kKeyCompanyValue] = company ? company : @"";
        }
        
        [peopleArray addObject:person];
    }
    
    return peopleArray;
}


static ContactsManager* __instance;
+ (instancetype) sharedInstance
{
    if(__instance == nil)
    {
        __instance = [[ContactsManager alloc] init];
    }
    return __instance;
}

+ (void) destroyInstance
{
    __instance = nil;
}
@end
