//
//  TTRegexKit.h
//  https://github.com/JadynSky/TTRegex
//
//  Created by WuZhongTian on 16/5/26.
//  Copyright (c) 2016年 WuZhongTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTRegexKit : NSObject


@property(nonatomic,assign)NSRange range;


@property(nonatomic,copy)NSString *text;


@property(nonatomic,assign)NSInteger index;


@property(nonatomic,assign)BOOL isRegular;

@end

@interface TTRegexKit : NSObject

/**
 *  1. 匹配正则规则的文字片段
 *
 *  @param text     传入需要验证的字符串
 *  @param pattern  传入正则表达式规则
 *  @param textPart 返回匹配正则规则的文字片段
 */
+(void)stringsMatchedByText:(NSString *)text pattern:(NSString *)pattern  TextPart:(void (^)(TTTextPart  *textPart))textPart;


/**
 *  2. 不匹配正则规则的文字片段
 *
 *  @param text     传入需要验证的字符串
 *  @param pattern  传入正则表达式规则
 *  @param textPart 返回不匹配正则规则的文字片段
 */
+(void)stringsSeparatedByText:(NSString *)text pattern:(NSString *)pattern  TextPart:(void (^)(TTTextPart  *textPart))textPart;


/**
 *  3. 全部文字片段,用正则规则分段
 *
 *  @param text     传入需要验证的字符串
 *  @param pattern  传入正则表达式规则
 *  @param textPart 返回全部文字片段,用正则规则分段
 */
+(void)stringsAllPartByText:(NSString *)text pattern:(NSString *)pattern  TextPart:(void (^)(TTTextPart  *textPart))textPart;


@end
