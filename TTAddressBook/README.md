# TTAddressBook

# 我是简介
这是一个封装好的通讯录类，适用于iOS9之前和之后。

1.包含通讯录字段：头像，全名，姓氏，名字，公司名，手机号，邮箱，地址，生日等。

2.包含文件：TTPersonModel  TTGetAddressBook  TTAddressBookHandle


# 使用

1.在info.plist中添加NSContactsUsageDescription字段的key，value为NSString格式，value的值将会在授权时展示出来。

2.在需要使用的类中#import "TTGetAddressBook.h"

3.授权访问通讯录

4.获取通讯录信息

```objective-c
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
```
