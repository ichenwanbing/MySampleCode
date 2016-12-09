//
//  MainButton.h
//  tic-tac-toe
//
//  Created by Jadyn on 16/8/4.
//  Copyright © 2016年 Yoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainButton : UIButton
@property (nonatomic, strong) UILabel *subLabel;

- (instancetype)initWithFrame:(CGRect)frame andi:(int)i andj:(int)j;
@end
