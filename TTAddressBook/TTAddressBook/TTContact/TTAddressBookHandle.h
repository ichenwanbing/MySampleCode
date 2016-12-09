//
//  TTDataHandle.h
//  TTAddressBook
//
//  Created by Jadyn on 16/9/19.
//  Copyright © 2016年 Jadyn. All rights reserved.
//

/*
 *********************************************************************************
 *
 * 在使用 TTGetAddressBook 中出现bug或有更好的建议,请及时联系我
 *
 * Email : wzt_940315@163.com
 * QQ    : 347092215
 * 简书   : http://www.jianshu.com/users/9785918f8c56/latest_articles
 * GitHub: https://github.com/JadynSky
 *
 *********************************************************************************
 */

#import <Foundation/Foundation.h>

#ifdef __IPHONE_9_0
#import <Contacts/Contacts.h>
#endif
#import <AddressBook/AddressBook.h>

#import "TTPersonModel.h"

/** 一个联系人的相关信息*/
typedef void(^TTPersonModelBlock)(TTPersonModel *model);
/** 授权失败的Block*/
typedef void(^AuthorizationFailure)(void);

@interface TTAddressBookHandle : NSObject

/**
 *  返回每个联系人的模型
 *
 *  @param personModel 单个联系人模型
 *  @param failure     授权失败的Block
 */
+ (void)getAddressBookDataSource:(TTPersonModelBlock)personModel authorizationFailure:(AuthorizationFailure)failure;

@end
