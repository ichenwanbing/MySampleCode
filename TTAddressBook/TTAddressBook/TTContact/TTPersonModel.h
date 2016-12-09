//
//  TTPersonModel.h
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
#import <UIKit/UIKit.h>

@interface TTPersonModel : NSObject

/** 联系人姓名*/
@property (nonatomic, copy) NSString *fullName;
/** 联系人名字*/
@property (nonatomic,copy) NSString *firstName;
/** 联系人姓氏*/
@property (nonatomic,copy) NSString *lastName;
/** 联系人公司名*/
@property (nonatomic,copy) NSString *companyName;
/** 联系人头像*/
@property (nonatomic, copy) UIImage *avatarImage;
/** 联系人QQ*/
@property (nonatomic,copy) NSString *qqNumber;
/** 联系人电话数组,因为一个联系人可能存储多个号码
 *  数组里面由  类型：电话号码 的字典组成
 *  示例 @[@{@"工作" : @"13333333333"},@{@"住宅" : @"0571-11111111"}]
 */
@property (nonatomic, strong) NSMutableArray *mobileArray;
/** 联系人邮箱数组,因为一个联系人可能存储多个号码
 *  数组里面由  类型：邮箱 的字典组成
 *  示例 @[@{@"工作" : @"abc@163.com"}]
 */
@property (nonatomic, strong) NSMutableArray *emailArray;
/** 联系人地址
 *  数组里面由  类型：地址详情字典  组成
 */
@property (nonatomic, strong) NSMutableArray *addressArray;
/** 联系人生日 时间戳*/
@property (nonatomic,copy) NSString *birthday;
@end
