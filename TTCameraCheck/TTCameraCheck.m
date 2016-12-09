//
//  TTCameraCheck.m
//  https://github.com/JadynSky/TTCameraCheck
//
//  Created by yoga on 16/5/26.
//  Copyright © 2016年 JadynSky. All rights reserved.
//

#import "TTCameraCheck.h"
@interface TTCameraCheck()


@end

@implementation TTCameraCheck
+ (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)isCameraAvailableFront
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}


+ (BOOL)isCameraAvailableRear
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL)isCameraFlashAvailableFront
{
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceFront];
}


+ (BOOL)isCameraFlashAvailableRear
{
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL)cameraSupportMediaWithType:(NSString *)paraMediaType
{
    NSArray *avaiableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    for (NSString *item in avaiableMedia) {
        if ([item isEqualToString:paraMediaType]) {
            return YES;
        }
    }
    return NO;
}
@end
