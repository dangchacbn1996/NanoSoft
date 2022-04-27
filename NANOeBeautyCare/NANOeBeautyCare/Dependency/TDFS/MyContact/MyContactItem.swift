//
//  MyContactItem.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//


import UIKit
import Contacts
import CoreTelephony

func transformationContacts(models: [CNContact]?) -> [MyContactItem] {
    var arrayData:[MyContactItem] = []
    if let model = models {
        for item in model {
            var image = UIImage(named: "logo")
            if let data = item.imageData {
                image = UIImage(data:data)
            }
            item.urlAddresses.map { (data) -> String in
                return data.value.abbreviatingWithTildeInPath
            }
            // item.note
            let data = MyContactItem(namePrefix: item.namePrefix ,
                                     givenName: item.givenName,
                                     middleName: item.middleName,
                                     familyName: item.familyName,
                                     previousFamilyName: item.previousFamilyName,
                                     nameSuffix: item.namePrefix ,
                                     nickname: item.nickname ,
                                     organizationName: item.organizationName ,
                                     departmentName: item.departmentName ,
                                     jobTitle: item.jobTitle ,
                                     phoneticGivenName: item.phoneticGivenName ,
                                     phoneticMiddleName: item.phoneticMiddleName ,
                                     phoneticFamilyName: item.phoneticFamilyName ,
                                     phoneticOrganizationName: item.phoneticOrganizationName ,
                                     note: "",
                                     imageData: "",
                                     phoneNumbers: item.phoneNumbers.map{$0.value.stringValue} ,
                                     emailAddresses: item.emailAddresses.map{$0.value as String} ,
                                     postalAddresses: item.postalAddresses.map{$0.value.street} ,
                                     urlAddresses: [], //item.urlAddresses.description.map{$0.value.abbreviatingWithTildeInPath} ?? [],
                                     contactRelations: [],//item.contactRelations.map{$0.value as String} ?? [],
                                     socialProfiles: [],//item.socialProfiles.map{$0.value as String} ?? [],
                                     instantMessageAddresses: [],//item.instantMessageAddresses.map{$0.value as String} ?? [],
                                     birthday: item.birthday ?? DateComponents(),
                                     nonGregorianBirthday: item.nonGregorianBirthday?.description ?? "",
                                     dates: item.dates.description )
            arrayData.append(data)
        }
    }
    return arrayData
}
struct MyContactItem {
    let namePrefix,givenName,middleName,familyName, previousFamilyName, nameSuffix, nickname: String
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *namePrefix;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *givenName;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *middleName;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *familyName;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *previousFamilyName;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *nameSuffix;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *nickname;
    let organizationName, departmentName, jobTitle: String
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *organizationName;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *departmentName;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *jobTitle;
    let phoneticGivenName, phoneticMiddleName, phoneticFamilyName, phoneticOrganizationName: String
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticGivenName;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticMiddleName;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticFamilyName;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *phoneticOrganizationName;
    let note: String
    //@property (copy, NS_NONATOMIC_IOSONLY) NSString *note;
    let imageData: String
    //@property (copy, nullable, NS_NONATOMIC_IOSONLY) NSData *imageData;
    let phoneNumbers, emailAddresses, postalAddresses, urlAddresses, contactRelations, socialProfiles, instantMessageAddresses: [String]
    //@property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNPhoneNumber*>*>               *phoneNumbers;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<NSString*>*>                    *emailAddresses;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNPostalAddress*>*>             *postalAddresses;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<NSString*>*>                    *urlAddresses;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNContactRelation*>*>           *contactRelations;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNSocialProfile*>*>             *socialProfiles;
    //@property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<CNInstantMessageAddress*>*>     *instantMessageAddresses;
    
    /*! @abstract The Gregorian birthday.
     *
     *  @description Only uses day, month and year components. Needs to have at least a day and a month.
     */
    let birthday: DateComponents
    //@property (copy, nullable, NS_NONATOMIC_IOSONLY) NSDateComponents *birthday;
    
    /*! @abstract The alternate birthday (Lunisolar).
     *
     *  @description Only uses day, month, year and calendar components. Needs to have at least a day and a month. Calendar must be Chinese, Hebrew or Islamic.
     */
    let nonGregorianBirthday: String
    //@property (copy, nullable, NS_NONATOMIC_IOSONLY) NSDateComponents *nonGregorianBirthday;
    
    /*! @abstract Other Gregorian dates (anniversaries, etc).
     *
     *  @description Only uses day, month and year components. Needs to have at least a day and a month.
     */
    let dates: String
    //@property (copy, NS_NONATOMIC_IOSONLY) NSArray<CNLabeledValue<NSDateComponents*>*> *dates;
}
