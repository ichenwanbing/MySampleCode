//
//  TTChangeColorBarView.h
//  CQOA
//
//  Created by Jadyn on 16/8/11.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TTChangeColorBarViewDelegate <NSObject>

- (void)sliderValueChangedWithColor:(UIColor *)color andValue1:(CGFloat)value1 andValue2:(CGFloat)value2;
@end


@interface TTChangeColorBarView : UIView
@property (nonatomic,weak) id<TTChangeColorBarViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame andValue1:(CGFloat)value1 andValue2:(CGFloat)value2;
@end
