//
//  ViewController.m
//  tic-tac-toe
//
//  Created by Jadyn on 16/8/4.
//  Copyright © 2016年 Yoga. All rights reserved.
//

#import "ViewController.h"
#import "MainButton.h"
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ScreenBoundsWidth ([UIScreen mainScreen].bounds.size.width-80)

@interface ViewController ()
@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UIButton *changeBeginButton;
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, strong) UIAlertController *alertView;

@property (nonatomic,assign) BOOL firstClick;
@property (nonatomic,assign) NSInteger totalCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tic-Tac-Toe";
    self.view.backgroundColor = RGBColor(238, 238, 238);
    self.navigationController.navigationBar.barTintColor = RGBColor(32, 198, 122);
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBColor(51, 51, 51),NSForegroundColorAttributeName,[UIFont systemFontOfSize:28],NSFontAttributeName, nil]];
    self.firstClick = YES;
    [self creatButtons];
    
}



- (void)creatButtons
{
    self.selectArray = [NSMutableArray array];
    [self resetSelectedArray];
    self.buttonArray = [NSMutableArray array];
    for (int i = 0; i < self.selectArray.count; i ++) {
        NSArray *arr = self.selectArray[i];
        NSMutableArray *buttonArr = [NSMutableArray array];
        for (int j = 0; j < arr.count; j++) {
            MainButton *button = [[MainButton alloc]initWithFrame:CGRectMake(40 + j*ScreenBoundsWidth/3, 40 + i * ScreenBoundsWidth / 3, ScreenBoundsWidth/3, ScreenBoundsWidth/3) andi:i andj:j];
            button.backgroundColor = (j+i)%2==1 ? RGBColor(255, 255, 255) : RGBColor(51, 51, 51);
            [button setTitleColor:(j+i)%2==1 ? RGBColor(51, 51, 51) : RGBColor(255, 255, 255) forState:UIControlStateNormal];
            NSInteger font = ScreenBoundsWidth > 320 ? 130 : 120;
            button.titleLabel.font = [UIFont systemFontOfSize:font];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, 0, 10, 0)];
            button.layer.borderWidth = (j+i)%2==1 ? 3 : 0;
            button.layer.borderColor = RGBColor(32, 198, 122).CGColor;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            [buttonArr addObject:button];
        }
        [self.buttonArray addObject:buttonArr];
    }
    
    UIButton *resetButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 50 - 64, self.view.frame.size.width, 50)];
    [resetButton setTitle:@"重新开始" forState:UIControlStateNormal];
    [resetButton setBackgroundColor:RGBColor(32, 198, 122)];
    [resetButton setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
    resetButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [resetButton addTarget:self action:@selector(onClickResetButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
    
    self.buttonTitle = @"x";
    UIButton *changeBeginButton = [[UIButton alloc]initWithFrame:CGRectMake(40 + ScreenBoundsWidth/2-50, self.view.frame.size.height - 160 - 64, 100, 30)];
    [changeBeginButton setTitle:@"x先走" forState:UIControlStateNormal];
    [changeBeginButton setBackgroundColor:RGBColor(32, 198, 122)];
    [changeBeginButton setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
    changeBeginButton.titleLabel.font = [UIFont systemFontOfSize:20];
    changeBeginButton.layer.cornerRadius = 5;
    changeBeginButton.layer.masksToBounds = YES;
    [changeBeginButton addTarget:self action:@selector(onClickChangeBeginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBeginButton];
    self.changeBeginButton = changeBeginButton;
}








#pragma mark - Action Event Method
- (void)onClickChangeBeginButton:(UIButton *)button
{
    [self changeStatus];
    [button setTitle:[NSString stringWithFormat:@"%@先走",self.buttonTitle] forState:UIControlStateNormal];
}

- (void)onClickResetButton
{
    self.totalCount = 0;
    self.firstClick = YES;
    [self resetSelectedArray];
    [self setButtonEnabledWithFlag:YES];
    if (!self.changeBeginButton.userInteractionEnabled) {
        self.changeBeginButton.userInteractionEnabled = YES;
    }
    for (NSArray *array in self.buttonArray) {
        for (UIButton *button in array) {
            [button setTitle:@"" forState:UIControlStateNormal];
            self.buttonTitle = @"x";
        }
    }
}

- (void)buttonClick:(MainButton *)button
{
    if (self.firstClick && [button.subLabel.text isEqualToString:@"11"]) {
        [self showActionSheetWithText:@"违反规则！！" andSubTitle:@"第一步棋不能下中间"];
        return;
    }
    
    
    
    if (self.changeBeginButton.userInteractionEnabled) {
        self.changeBeginButton.userInteractionEnabled = NO;
    }
    if (button.currentTitle.length != 0) {
        return;
    }
    [button setTitle:self.buttonTitle forState:UIControlStateNormal];
    self.totalCount ++;
    
    if (self.firstClick) {
        self.firstClick = NO;
    }
    [self setSelectToSelectArrayWithButton:button];
    [self checkOutWin];
    [self changeStatus];
    if (self.totalCount == 9) {
        [self showActionSheetWithText:@"游戏结束" andSubTitle:@"没有位置可以下了，点击重置键盘"];
        return;
    }
}


#pragma mark - Prvivte Method

- (void)resetSelectedArray
{
    if (self.selectArray) {
        [self.selectArray removeAllObjects];
    }
    for (int k = 0; k < 3; k ++) {
        NSArray *arr1 = @[@"",@"",@""];
        NSMutableArray *arrM1 = [NSMutableArray arrayWithArray:arr1];
        [self.selectArray addObject:arrM1];
    }
}
- (void)changeStatus
{
    if ([self.buttonTitle isEqualToString:@"x"]) {
        self.buttonTitle = @"o";
    }else {
        self.buttonTitle = @"x";
    }
}

- (void)showActionSheetWithText:(NSString *)string andSubTitle:(NSString *)subString
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:string message:subString preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self onClickResetButton];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)checkOutWin
{
    int x1Count = 0;
    int o1Count = 0;
    int x2Count = 0;
    int o2Count = 0;
    for (int i = 0; i < 3; i++) {
        int xhCount = 0;
        int ohCount = 0;
        int xlCount = 0;
        int olCount = 0;
        
        for (int j = 0; j < 3; j++) {
            if (i == j) {
                if ([self.selectArray[i][j] isEqualToString:@"x"]) {
                    x1Count ++;
                }else if ([self.selectArray[j][i] isEqualToString:@"o"]) {
                    o1Count ++;
                }
            }
            if (i + j == 2) {
                if ([self.selectArray[i][j] isEqualToString:@"x"]) {
                    x2Count ++;
                }else if ([self.selectArray[j][i] isEqualToString:@"o"]) {
                    o2Count ++;
                }
            }
            
            if ([self.selectArray[i][j] isEqualToString:@"x"]) {
                xhCount ++;
            }else if ([self.selectArray[i][j] isEqualToString:@"o"]) {
                ohCount ++;
            }
            
            if ([self.selectArray[j][i] isEqualToString:@"x"]) {
                xlCount ++;
            }else if ([self.selectArray[j][i] isEqualToString:@"o"]) {
                olCount ++;
            }
        }
        if (x1Count == 3 || x2Count == 3 || xhCount == 3 || xlCount == 3) {
            [self showActionSheetWithText:@"X获胜啦！" andSubTitle:@"点击重置棋盘"];
            [self setButtonEnabledWithFlag:NO];
            return;
        }else if (o1Count == 3 || o2Count == 3 || ohCount == 3 || olCount == 3) {
            [self showActionSheetWithText:@"O获胜啦！" andSubTitle:@"点击重置棋盘"];
            [self setButtonEnabledWithFlag:NO];
            return;
        }
    }
}


- (void)setButtonEnabledWithFlag:(BOOL)flag
{
    for (NSArray *arr in self.buttonArray) {
        for (UIButton *button in arr) {
            button.userInteractionEnabled = flag;
        }
    }
}


- (void) setSelectToSelectArrayWithButton:(MainButton *)button
{
    int i = 0;
    int j = 0;
    i = [[button.subLabel.text substringWithRange:NSMakeRange(0, 1)] intValue];
    j = [[button.subLabel.text substringWithRange:NSMakeRange(1, 1)] intValue];
    for (int a = 0; a < self.selectArray.count; a++) {
        NSMutableArray *arr = self.selectArray[a];
        if (a == i) {
            for (int b = 0; b < arr.count; b ++) {
                if (b == j) {
                    [arr replaceObjectAtIndex:b withObject:self.buttonTitle];
                }
            }
        }
    }
}




@end
