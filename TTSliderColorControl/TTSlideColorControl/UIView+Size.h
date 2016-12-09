//
//  UIView+Size.h
//  DDExpressCourier
//
//  Created by ywp on 16-2-23.
//  Copyright (c) 2016年 NS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Size)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

//外部中心
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//内部中心
@property (nonatomic, assign) CGFloat centerx;
@property (nonatomic, assign) CGFloat centery;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end
