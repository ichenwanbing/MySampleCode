//
//  DetailViewController.m
//  TTAddressBook
//
//  Created by Jadyn.Wu on 2016/9/25.
//  Copyright © 2016年 Yoga. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *fullName;

@property (nonatomic, strong) UILabel *lastName;

@property (nonatomic, strong) UILabel *firstName;

@property (nonatomic, strong) UILabel *companyName;

@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) UILabel *emailLabel;

@property (nonatomic, strong) UILabel *birthdayLabel;

@end

@implementation DetailViewController
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"联系人详情";
    [self initViews];
    [self addViews];
    [self addDatas];
}


- (void)initViews
{
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 40, 40)];
    self.fullName = [[UILabel alloc] initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, 40)];
    self.fullName.text = @"全名：";
    self.lastName = [[UILabel alloc] initWithFrame:CGRectMake(0, 144, self.view.frame.size.width, 40)];
    self.lastName.text = @"姓氏：";
    self.firstName = [[UILabel alloc] initWithFrame:CGRectMake(0, 184, self.view.frame.size.width, 40)];
    self.firstName.text = @"名字：";
    self.companyName = [[UILabel alloc] initWithFrame:CGRectMake(0, 224, self.view.frame.size.width, 40)];
    self.companyName.text = @"公司名：";
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 264, self.view.frame.size.width, 40)];
    self.phoneLabel.text = @"手机号：";
    self.emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 304, self.view.frame.size.width, 40)];
    self.emailLabel.text = @"邮箱：";
    self.birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 344, self.view.frame.size.width, 40)];
    self.birthdayLabel.text = @"生日：";
}



- (void)addViews
{
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.fullName];
    [self.view addSubview:self.lastName];
    [self.view addSubview:self.firstName];
    [self.view addSubview:self.companyName];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.emailLabel];
    [self.view addSubview:self.birthdayLabel];
}


- (void) addDatas
{
    if (self.model.avatarImage) {
        self.imgView.image = self.model.avatarImage;
    }
    self.fullName.text = [self.fullName.text stringByAppendingString:self.model.fullName?:@""];
    self.lastName.text = [self.lastName.text stringByAppendingString:self.model.lastName?:@""];
    self.firstName.text = [self.firstName.text stringByAppendingString:self.model.firstName?:@""];
    self.companyName.text = [self.companyName.text stringByAppendingString:self.model.companyName?:@""];
    for (NSDictionary *dic in self.model.mobileArray) {
        NSString *phone = [[dic allValues] firstObject];
        self.phoneLabel.text = [self.phoneLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@  ",phone]];
    }
    
    for (NSDictionary *dic in self.model.emailArray) {
        NSString *email = [[dic allValues] firstObject];
        self.emailLabel.text = [self.emailLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@  ",email]];
    }
    
    if (self.model.birthday.length == 13) {
        self.model.birthday = [self.model.birthday substringToIndex:10];
    }
    
    if (self.model.birthday.length == 10) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self.model.birthday doubleValue]];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStr = [df stringFromDate:date];
        self.birthdayLabel.text = [self.birthdayLabel.text stringByAppendingString:dateStr];
    }
}



@end
