//
//  TTDataHandle.m
//  TTAddressBook
//
//  Created by Jadyn on 16/9/19.
//  Copyright © 2016年 Jadyn. All rights reserved.
//

#import "TTAddressBookHandle.h"

@implementation TTAddressBookHandle

+ (void)getAddressBookDataSource:(TTPersonModelBlock)personModel authorizationFailure:(AuthorizationFailure)failure
{
    
    if([[UIDevice currentDevice] systemVersion].floatValue > 9.0)
    {
        [self getDataSourceBeforeIOS9FromModel:personModel authorizationFailure:failure];
    }
    else
    {
        [self getDataSourceAfterIOS9FromModel:personModel authorizationFailure:failure];
    }
    
}

#pragma mark - iOS9之前获取通讯录的方法
+ (void)getDataSourceBeforeIOS9FromModel:(TTPersonModelBlock)personModel authorizationFailure:(AuthorizationFailure)failure
{
    // 1.获取授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    // 2.如果没有授权,先执行授权失败的block后return
    if (status != kABAuthorizationStatusAuthorized/** 已经授权*/)
    {
        failure ? failure() : nil;
        return;
    }
    
    // 3.创建通信录对象
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // 4.按照排序规则从通信录对象中请求所有的联系人,并按姓名属性中的姓(LastName)来排序
    ABRecordRef recordRef = ABAddressBookCopyDefaultSource(addressBook);
    CFArrayRef allPeopleArray = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, recordRef, kABPersonSortByLastName);
    
    // 5.遍历每个联系人的信息,并装入模型
    for(id personInfo in (__bridge NSArray *)allPeopleArray)
    {
        TTPersonModel *model = [TTPersonModel new];
        
        // 获取到联系人
        ABRecordRef person = (__bridge ABRecordRef)(personInfo);
        
        // 获取全名
        NSString *fullName = (__bridge_transfer NSString *)ABRecordCopyCompositeName(person);
        model.fullName = fullName.length > 0 ? fullName : @"无姓名" ;
        
        // 获取头像数据
        NSData *imageData = (__bridge_transfer NSData *)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
        model.avatarImage = [UIImage imageWithData:imageData];
        
        // 获取姓氏
        NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        model.lastName = lastName.length > 0 ? lastName : @"";
        
        // 获取名字
        NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        model.firstName = firstName.length > 0 ? firstName : @"";
        
        // 获取公司名
        NSString *companyName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
        model.companyName = companyName.length > 0 ? companyName : @"";
        
        // 获取每个人所有的电话号码
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        for (CFIndex i = 0; i < phoneCount; i++)
        {
            NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
            NSString *mobile = [self removeSpecialSubString:phoneValue];
            NSString* phoneName = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phones, i));
            
            if (mobile.length > 0) {
                NSDictionary *mobileDic = [NSDictionary dictionaryWithObject:mobile forKey:phoneName ? phoneName : @""];
                [model.mobileArray addObject: mobileDic];
            }
        }
        
        // 获取每个人的所有邮箱地址
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
        CFIndex emailCount = ABMultiValueGetCount(emails);
        for (CFIndex j = 0; j < emailCount; j ++) {
            NSString *emailValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, j);
            NSString *emailName = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(emails, j));
            
            if (emailValue.length > 0) {
                NSDictionary *emailDic = [NSDictionary dictionaryWithObject:emailValue forKey:emailName ? emailName : @""];
                [model.emailArray addObject: emailDic];
            }
        }
        
        // 获取生日
        ABMultiValueRef birthdays = ABRecordCopyValue(person, kABPersonAlternateBirthdayProperty);
        CFIndex countDate = ABMultiValueGetCount(birthdays);
        for (CFIndex k = 0; k < countDate; k++)
        {
            NSString* birthdayName = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(birthdays, k));
            if ([birthdayName isEqualToString:@"生日"]) {
                NSString* birthdayValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(birthdays, k);
                model.birthday = birthdayValue.length > 0 ? birthdayValue : @"";
            }
        }
        
        // 获取QQ号
        ABMultiValueRef instantMessages = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
        CFIndex instantCount = ABMultiValueGetCount(instantMessages);
        for (CFIndex l = 0; l < instantCount; l ++)
        {
            NSString *instantMessageName = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(instantMessages, l));
            if ([instantMessageName isEqualToString:@"QQ"]) {
                NSString *instantMessageValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(instantMessages, l);
                model.qqNumber = instantMessageValue.length > 0 ? instantMessageValue : @"";
            }
        }
        
        //读取地址多值
        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
        NSInteger count = ABMultiValueGetCount(address);
        for(NSInteger j = 0; j < count; j++)
        {
            NSMutableDictionary *addressMdic = [NSMutableDictionary dictionary];
            
            NSString *addressName = (__bridge_transfer NSString *)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(address, j));
            //获取該label下的地址6属性
            NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
            NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
            [addressMdic setObject:country ?: @"" forKey:@"country"];
            NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
            [addressMdic setObject:city ?: @"" forKey:@"city"];
            NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
            [addressMdic setObject:state ?: @"" forKey:@"state"];
            NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
            [addressMdic setObject:street ?: @"" forKey:@"street"];
            NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
            [addressMdic setObject:zip ?: @"" forKey:@"zip"];
            NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
            [addressMdic setObject:coutntrycode ?: @"" forKey:@"coutntrycode"];
            NSDictionary *dic = [NSDictionary dictionaryWithObject:addressMdic forKey:addressName];
            [model.addressArray addObject:dic];
        }
        // 5.将联系人模型回调出去
        personModel(model);
        
        CFRelease(phones);
    }
    
    // 释放不再使用的对象
    CFRelease(allPeopleArray);
    CFRelease(addressBook);
    
}

#pragma mark - IOS9之后获取通讯录的方法
+ (void)getDataSourceAfterIOS9FromModel:(TTPersonModelBlock)personModel authorizationFailure:(AuthorizationFailure)failure
{
#ifdef __IPHONE_9_0
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    // 2.如果没有授权,先执行授权失败的block后return
    if (status != CNAuthorizationStatusAuthorized)
    {
        failure ? failure() : nil;
        return;
    }
    // 3.获取联系人
    // 3.1.创建联系人仓库
    CNContactStore *store = [[CNContactStore alloc] init];
    
    // 3.2.创建联系人的请求对象
    // keys决定能获取联系人哪些信息,例:姓名,电话,头像等
    NSArray *fetchKeys = @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey,CNContactFamilyNameKey,CNContactGivenNameKey,CNContactBirthdayKey,CNContactOrganizationNameKey,CNContactPostalAddressesKey,CNContactInstantMessageAddressesKey,CNContactEmailAddressesKey];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetchKeys];
    
    // 3.3.请求联系人
    [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact,BOOL * _Nonnull stop) {
        
        // 获取联系人全名
        NSString *name = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
        
        // 创建联系人模型
        TTPersonModel *model = [TTPersonModel new];
        model.fullName = name.length > 0 ? name : @"无姓名" ;
        
        //获取名字
        NSString *firstName = contact.givenName;
        model.firstName = firstName.length > 0 ? firstName : @"";
        // 联系人头像
        model.avatarImage = [UIImage imageWithData:contact.thumbnailImageData];
        //获取姓氏
        NSString *lastName = contact.familyName;
        model.lastName = lastName.length > 0 ? lastName : @"";
        //获取公司名
        NSString *companyName = contact.organizationName;
        model.companyName = companyName.length > 0 ? companyName : @"";
        //获取邮箱
        NSArray *emails = contact.emailAddresses;
        for (CNLabeledValue *labelValue in emails) {
            NSString *emailStr = labelValue.value;
            NSString *emailName = labelValue.label;
            if (emailStr.length > 0) {
                NSDictionary *dic = [NSDictionary dictionaryWithObject:emailStr forKey:emailName?:@""];
                [model.emailArray addObject:dic];
            }
        }
        
        // 获取一个人的所有电话号码
        NSArray *phones = contact.phoneNumbers;
        for (CNLabeledValue *labelValue in phones)
        {
            CNPhoneNumber *phoneNumber = labelValue.value;
            NSString *mobile = [self removeSpecialSubString:phoneNumber.stringValue];
            NSString *phoneName = labelValue.label;
            if (mobile.length > 0) {
                NSDictionary *dic = [NSDictionary dictionaryWithObject:mobile forKey:phoneName?:@""];
                [model.mobileArray addObject:dic];
            }
        }
        
        
        //获取QQ号
        NSArray *instansMessages = contact.instantMessageAddresses;
        for (CNLabeledValue *labelValue in instansMessages)
        {
            CNInstantMessageAddress *instantMessage = labelValue.value;
            NSString *instantMessageValue = instantMessage.username;
            NSString *instantMessageName = labelValue.label;
            if ([instantMessageName isEqualToString: @"QQ"]) {
                model.qqNumber = instantMessageValue.length > 0 ? instantMessageValue : @"";
            }
        }
        
        
        //获取地址
        NSArray *addresses = contact.postalAddresses;
        for (CNLabeledValue *labelValue in addresses) {
            NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
            CNPostalAddress *address = labelValue.value;
            [dicM setObject:address.country ?: @"" forKey:@"country"];
            [dicM setObject:address.street ?: @"" forKey:@"street"];
            [dicM setObject:address.state ?: @"" forKey:@"state"];
            [dicM setObject:address.city ?: @"" forKey:@"city"];
            [dicM setObject:address.postalCode ?: @"" forKey:@"postalCode"];
            NSString *addressName = labelValue.label;
            if (addressName.length > 0) {
                NSDictionary *dic = [NSDictionary dictionaryWithObject:dicM forKey:addressName];
                [model.addressArray addObject:dic];
            }
        }
        
        //获取生日
        NSDateComponents *birthdayComponent = contact.birthday;
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *birthDayDate =[gregorian dateFromComponents:birthdayComponent];
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[birthDayDate timeIntervalSince1970]];
        model.birthday = timeSp.length > 0 ? timeSp : @"";
        
        //将联系人模型回调出去
        personModel(model);
    }];
#endif
    
}

//过滤指定字符串(可自定义添加自己过滤的字符串)
+ (NSString *)removeSpecialSubString: (NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return string;
}

@end
