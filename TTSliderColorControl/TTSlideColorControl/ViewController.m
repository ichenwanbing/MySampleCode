//
//  ViewController.m
//  TTSlideColorControl
//
//  Created by Jadyn on 16/8/24.
//  Copyright © 2016年 Yoga. All rights reserved.
//

#import "ViewController.h"
#import "TTChangeColorBarView.h"


#define VALUE1 0.0
#define VALUE2 0.5
@interface ViewController ()<TTChangeColorBarViewDelegate>

@property (nonatomic, strong) TTChangeColorBarView *sliderBarView;

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UILabel *mainLabel;
@end

@implementation ViewController
#pragma mark - View Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.mainLabel];
    [self.view addSubview:self.sliderBarView];
    self.mainLabel.text = [NSString stringWithFormat:@"R:%lu G:%lu B:%lu V1:%.2f V2:%.2f",255,255,255,0.00,1.00];
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.mainView.frame = CGRectMake(0, 0, 100, 100);
    self.mainView.center = self.view.center;
    self.mainLabel.frame = CGRectMake(0, self.mainView.frame.origin.y - 50, self.view.frame.size.width, 20);
}





- (void)sliderValueChangedWithColor:(UIColor *)color andValue1:(CGFloat)value1 andValue2:(CGFloat)value2
{
    self.mainView.backgroundColor = color;
    NSArray *arr = [self getRGBAFromColor:color];
    NSInteger redInt = [arr[0] floatValue] * 255;
    NSInteger greenInt = [arr[1] floatValue] * 255;
    NSInteger blueInt = [arr[2] floatValue] * 255;
    
    self.mainLabel.text = [NSString stringWithFormat:@"R:%lu G:%lu B:%lu V1:%.2f V2:%.2f",redInt,greenInt,blueInt,value1,value2];
}


-(NSArray *)getRGBAFromColor:(UIColor *)color {
    
    CGFloat Red, green, Blue, alpha;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    Red   = components[0];
    green = components[1];
    Blue  = components[2];
    alpha = components[3];
    NSArray *arr = @[@(Red),@(green),@(Blue),@(alpha)];
    return arr;
}


- (UIView *)mainView
{
    if (_mainView == nil) {
        _mainView = [[UIView alloc]init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (UILabel *)mainLabel
{
    if (_mainLabel == nil) {
        _mainLabel = [[UILabel alloc]init];
        _mainLabel.textAlignment = NSTextAlignmentCenter;
        _mainLabel.textColor = [UIColor blackColor];
        _mainLabel.font = [UIFont systemFontOfSize:20];
    }
    return _mainLabel;
}

- (TTChangeColorBarView *)sliderBarView
{
    if (_sliderBarView == nil) {
        _sliderBarView = [[TTChangeColorBarView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 120, self.view.frame.size.width, 120) andValue1:VALUE1 andValue2:VALUE2];
        _sliderBarView.delegate = self;
    }
    return _sliderBarView;
}






@end
