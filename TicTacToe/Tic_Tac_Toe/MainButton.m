//
//  MainButton.m
//  tic-tac-toe
//
//  Created by Jadyn on 16/8/4.
//  Copyright © 2016年 Yoga. All rights reserved.
//

#import "MainButton.h"

@implementation MainButton
- (instancetype)initWithFrame:(CGRect)frame andi:(int)i andj:(int)j
{
    self = [super initWithFrame:frame];
    if (self) {
        self.subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
        self.subLabel.text = [NSString stringWithFormat:@"%d%d",i,j];
        self.subLabel.textColor = [UIColor clearColor];
        [self addSubview:self.subLabel];
    }
    return self;
}

@end
