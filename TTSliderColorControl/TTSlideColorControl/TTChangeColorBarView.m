//
//  TTChangeColorBarView.m
//  CQOA
//
//  Created by Jadyn on 16/8/11.
//  Copyright © 2016年 ChinaMobile. All rights reserved.
//

#import "TTChangeColorBarView.h"
#import "UIView+Size.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface TTChangeColorBarView()
//颜色
@property (nonatomic, strong) UISlider *sliderColor;
//亮度
@property (nonatomic, strong) UISlider *sliderGray;
//颜色渐变图层
@property (nonatomic, strong) CAGradientLayer *layerColor;
//亮度渐变图层
@property (nonatomic, strong) CAGradientLayer *layerGray;

@property (nonatomic, strong) UIColor *currentColor;

@end
@implementation TTChangeColorBarView
- (instancetype)initWithFrame:(CGRect)frame andValue1:(CGFloat)value1 andValue2:(CGFloat)value2
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
        [self setSlider:self.sliderColor withValue:value1];
        [self setSlider:self.sliderGray withValue:value2];
    }
    return self;
}


- (void)createViews
{
    self.backgroundColor = UIColorFromRGB(0xffffff);
    [self createTwoLayer];
    [self addSubview:self.sliderColor];
    [self addSubview:self.sliderGray];
}

- (void)createTwoLayer
{
    [self.layer addSublayer:self.layerColor];
    [self.layer addSublayer:self.layerGray];
}



#pragma mark - Prvivte Method
- (void)setSlider:(UISlider *)slider withValue:(CGFloat)value
{
    slider.value = value;
}



- (void)setLayerWithColor:(UIColor *)color
{
    CAGradientLayer *newLayer = [CAGradientLayer layer];
    newLayer.frame = self.layerGray.frame;
    newLayer.colors = @[
                      (__bridge id) [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor,
                      (__bridge id) color.CGColor,
                      (__bridge id) [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1].CGColor,];
    newLayer.startPoint = CGPointMake(0, 0);
    newLayer.endPoint = CGPointMake(1, 0);
    newLayer.cornerRadius = 3;
    newLayer.masksToBounds = YES;
    [self.layer replaceSublayer:self.layerGray with:newLayer];
    self.layerGray = newLayer;
}



- (UIColor *)colorOfPoint:(CGPoint)point andLayer:(CAGradientLayer *)layer{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

- (CGPoint)layerPointWithSliderValue:(CGFloat)value
{
    return CGPointMake(value < 0.5 ? (value * (self.layerColor.frame.size.width)) : ((value-0.02) * (self.layerColor.frame.size.width)), 3);
}



#pragma mark - Action Event Method
- (void)sliderDidChange:(UISlider *)slider
{
    if (slider == self.sliderColor) {
        CGPoint pt = [self layerPointWithSliderValue:slider.value];
        UIColor *cl = [self colorOfPoint:pt andLayer:self.layerColor];
        [self setLayerWithColor:cl];
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderValueChangedWithColor:andValue1:andValue2:)]) {
        CGPoint pt2 = [self layerPointWithSliderValue:self.sliderGray.value];
        UIColor *cl2 = [self colorOfPoint:pt2 andLayer:self.layerGray];
        [self.delegate sliderValueChangedWithColor:cl2 andValue1:self.sliderColor.value + 0.001 andValue2:self.sliderGray.value + 0.001];
        
        NSLog(@"___color is ____%@",cl2);
    }
}


#pragma mark - Setter && Getter
- (UISlider *)sliderColor
{
    if (_sliderColor == nil) {
        _sliderColor = [[UISlider alloc]initWithFrame:CGRectMake(24, 10, self.width-74 + 26, 36)];
        _sliderColor.value = 1;
        _sliderColor.maximumTrackTintColor = [UIColor clearColor];
        _sliderColor.minimumTrackTintColor = [UIColor clearColor];
        [_sliderColor addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderColor;
}

- (UISlider *)sliderGray
{
    if (_sliderGray == nil) {
        _sliderGray = [[UISlider alloc]initWithFrame:CGRectMake(self.sliderColor.x, self.sliderColor.bottom + 13, self.sliderColor.width, 36)];
        _sliderGray.value = 1;
        _sliderGray.maximumTrackTintColor = [UIColor clearColor];
        _sliderGray.minimumTrackTintColor = [UIColor clearColor];
        [_sliderGray addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderGray;
}

- (CAGradientLayer *)layerColor
{
    if (_layerColor == nil) {
        _layerColor = [CAGradientLayer layer];
        _layerColor.frame = CGRectMake(35, 25, self.width-70, 6);
        //颜色分配:四个一组代表一种颜色(r,g,b,a)
        _layerColor.colors = @[
                         (__bridge id) [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor,
                         (__bridge id) [UIColor colorWithRed:255/255.0 green:255/255.0 blue:0/255.0 alpha:1].CGColor,
                         (__bridge id) [UIColor colorWithRed:0/255.0 green:255/255.0 blue:0/255.0 alpha:1].CGColor,
                         (__bridge id) [UIColor colorWithRed:0/255.0 green:255/255.0 blue:255/255.0 alpha:1].CGColor,
                         (__bridge id) [UIColor colorWithRed:0/255.0 green:0/255.0 blue:255/255.0 alpha:1].CGColor,
                         (__bridge id) [UIColor colorWithRed:255/255.0 green:0/255.0 blue:255/255.0 alpha:1].CGColor,
                         (__bridge id) [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor];
        //起始点
        _layerColor.startPoint = CGPointMake(0, 0);
        //结束点
        _layerColor.endPoint = CGPointMake(1, 0);
        _layerColor.cornerRadius = 3;
        _layerColor.masksToBounds = YES;
    }
    return _layerColor;
}


- (CAGradientLayer *)layerGray
{
    if (_layerGray == nil) {
        _layerGray = [CAGradientLayer layer];
        _layerGray.frame = CGRectMake(35, self.sliderColor.bottom + 30, self.width-70, 6);
        //颜色分配:四个一组代表一种颜色(r,g,b,a)
        _layerGray.colors = @[
                          (__bridge id) [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor,
                          (__bridge id) [UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor,
                          (__bridge id) [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1].CGColor,];
        //起始点
        _layerGray.startPoint = CGPointMake(0, 0);
        //结束点
        _layerGray.endPoint = CGPointMake(1, 0);
        _layerGray.cornerRadius = 4;
        _layerGray.masksToBounds = YES;
    }
    return _layerGray;
}
@end
