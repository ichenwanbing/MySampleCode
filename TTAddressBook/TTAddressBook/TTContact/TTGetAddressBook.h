//
//  TTGetAddressBook.h
//  TTGetAddressBook
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
#import "TTAddressBookHandle.h"
#import "TTPersonModel.h"

/**
 *  获取原始顺序的所有联系人的Block
 */
typedef void(^AddressBookArrayBlock)(NSArray<TTPersonModel *> *addressBookArray);

/**
 *  获取按A~Z顺序排列的所有联系人的Block
 *
 *  @param addressBookDict @"A"->由TTPersonModel组成的数组
 *  @param nameKeys   联系人姓名的大写首字母的数组
 */
typedef void(^AddressBookDictBlock)(NSDictionary<NSString *,NSArray *> *addressBookDict,NSArray *nameKeys);



@interface TTGetAddressBook : NSObject

/**
 *  请求用户是否授权APP访问通讯录的权限,建议在APPDeletegate.m中的didFinishLaunchingWithOptions方法中调用
 */
+ (void)requestAddressBookAuthorization;

/**
 *  获取原始顺序排列的所有联系人
 *
 *  @param addressBookArray 装着原始顺序的联系人字典Block回调
 */
+ (void)getOriginalAddressBook:(AddressBookArrayBlock)addressBookArray authorizationFailure:(AuthorizationFailure)failure;



/**
 *  获取按A~Z顺序排列的所有联系人
 *
 *  @param addressBookInfo 装着A~Z排序的联系人字典Block回调
 *  @param failure         授权失败的Block
 */
+ (void)getOrderAddressBook:(AddressBookDictBlock)addressBookInfo authorizationFailure:(AuthorizationFailure)failure;


@end
