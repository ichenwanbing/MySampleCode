//
//  TTCameraCheck.h
//  https://github.com/JadynSky/TTCameraCheck
//
//  Created by yoga on 16/5/26.
//  Copyright © 2016年 JadynSky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
@interface TTCameraCheck : NSObject

/**
 *  相机是否可用
 *
 *  @return 是->可用
 */
+ (BOOL)isCameraVailiable;

/**
 *  相机前置摄像头是否可用
 *
 *  @return 是->可用
 */
+ (BOOL)isCameraVailiableFront;

/**
 *  相机后置摄像头是否可用
 *
 *  @return 是->可用
 */
+ (BOOL)isCameraVailiableRear;

/**
 *  相机前置闪光灯是否可用
 *
 *  @return 是->可用
 */
+ (BOOL)isCameraFlashVailiableFront;

/**
 *  相机后置闪光灯是否可用
 *
 *  @return 是->可用
 */
+ (BOOL)isCameraFlashVailiableRear;

/**
 *  相机是否支持类型可用
 *
 *  @param paraMediaType 传入相机支持类型   例(__bridge NSString *)kUTTypeImage 须添加#import <MobileCoreServices/UTCoreTypes.h>
 *
 *  @return YES 相机支持当前类型
 */
+ (BOOL)cameraSupportMediaWithType:(NSString *)paraMediaType;


@end
