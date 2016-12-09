//
//  UITableView+DefaultPage.h
//  https://github.com/JadynSky/TTDefaultPage
//
//  Created by WuZhongTian on 16/4/20.
//  Copyright © 2016年 WuZhongTian. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UITableView (DefaultPage)

@property (nonatomic, strong, readonly) UIView *defaultPageView;

/**
 *  添加一个TableView背景的缺省页
 *
 *  @param imageName    主图片
 *  @param title        图片下方主文字
 */
-(void)addDefaultPageWithImageName:(NSString *)imageName andTitle:(NSString *)title;


/**
 *  添加一个TableView背景的缺省页
 *
 *  @param imageName    主图片
 *  @param title        图片下方主文字
 *  @param subTitle     图片下方副文字
 */
-(void)addDefaultPageWithImageName:(NSString *)imageName andTitle:(NSString *)title andSubTitle:(NSString *)subTitle;


/**
 *  添加一个TableView背景的缺省页
 *
 *  @param imageName    主图片
 *  @param title        图片下方主文字
 *  @param subTitle     图片下方副文字
 *  @param btnImageName 按钮图片
 *  @param btnTitle     按钮文字
 *  @param action       按钮点击事件
 */
-(void)addDefaultPageWithImageName:(NSString *)imageName andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andBtnImage:(NSString *)btnImageName andbtnTitle:(NSString *)btnTitle andBtnAction:(SEL)action;


/**
 *  添加一个TableView背景的缺省页
 *
 *  @param imageName    主图片
 *  @param title        图片下方主文字
 *  @param subTitle     图片下方副文字
 *  @param btnImageName 按钮图片
 *  @param btnTitle     按钮文字
 *  @param action       按钮点击事件
 *  @param target       按钮事件Target
 */
-(void)addDefaultPageWithImageName:(NSString *)imageName andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andBtnImage:(NSString *)btnImageName andbtnTitle:(NSString *)btnTitle andBtnAction:(SEL)action withTarget:(id)target;


/**
 *  设置TableView背景的缺省页的样式
 *
 *  @param imageName    主图片
 *  @param title        图片下方主文字
 *  @param subTitle     图片下方副文字
 *  @param btnImageName 按钮图片
 *  @param btnTitle     按钮文字
 *  @param action       按钮点击事件
 */
- (void)setDefaultPageWithImageName:(NSString *)imageName andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andBtnImage:(NSString *)btnImageName andbtnTitle:(NSString *)btnTitle andBtnAction:(SEL)action;


/**
 *  设置TableView背景的缺省页的样式
 *
 *  @param imageName    主图片
 *  @param title        图片下方主文字
 *  @param subTitle     图片下方副文字
 *  @param btnImageName 按钮图片
 *  @param btnTitle     按钮文字
 *  @param action       按钮点击事件
 *  @param target       按钮事件Target
 */
- (void)setDefaultPageWithImageName:(NSString *)imageName andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andBtnImage:(NSString *)btnImageName andbtnTitle:(NSString *)btnTitle andBtnAction:(SEL)action withTarget:(id)target;
@end
