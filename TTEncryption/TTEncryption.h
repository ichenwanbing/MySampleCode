//
//  TTEncryption.h
//  https://github.com/JadynSky/TTEncryption
//
//  Created by wzt on 15/7/31.
//  Copyright (c) 2015年 wzt. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const Des3Key;                                                                                         /**< des3加密key */
extern NSString *const Des3Iv;                                                                                          /**< des3加密iv */


@interface TTEncryption : NSObject

#pragma mark Public Base64

/**
 *  获得一个base64加密的字符串
 *
 *  @param string 需要加密的字符串
 *
 *  @return 加密的字符串 nil 加密失败
 */
+ (NSString *)tt_stringWithBase64EncryptionString:(NSString *)string;

/**
 *  获得base64解密的字符串
 *
 *  @param string 需要解密的字符串
 *
 *  @return 解密字符串 nil 解密失败
 */
+ (NSString *)tt_stringWithBase64DecryptionString:(NSString *)string;

#pragma mark Public 3DES

/**
 *  获得一个3DES+Base64加密的字符串
 *
 *  @param string 要加密的字符串
 *
 *  @return 加密的字符串
 */
+ (NSString *)tt_stringWithDesEncryptionString:(NSString*)string;

/**
 *  获得一个Base64+3DES解密的字符串
 *
 *  @param string 要解密的字符串
 *
 *  @return 解密的字符串
 */
+ (NSString *)tt_stringWithDesDecryptionString:(NSString*)string;

#pragma mark Public MD5

/**
 *  获得一个MD5加密字符串
 *
 *  @param string 要加密的字符串
 *
 *  @return 加密的字符串
 */
+ (NSString *)tt_stringWithMD5EncryptionString:(NSString*)string;

@end
