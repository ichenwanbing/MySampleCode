//
//  ViewController.m
//  TTAddressBook
//
//  Created by Jadyn on 16/9/21.
//  Copyright © 2016年 Yoga. All rights reserved.
//

#import "ViewController.h"
#import "TTGetAddressBook.h"
#import "TTPersonModel.h"
#import "DetailViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSArray *letterArray;
@property (nonatomic, strong) NSMutableArray *contactArray;
@property (nonatomic, strong) NSDictionary *contactDic;
@end

@implementation ViewController
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"简易通讯录";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.button];
    [self.view addSubview:self.tableView];
    [TTGetAddressBook requestAddressBookAuthorization];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.button setFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
}

#pragma mark - Action Method
- (void)onClickButton
{
    self.tableView.hidden = NO;
    [TTGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
        self.letterArray = nameKeys;
        self.contactDic = addressBookDict;
        [self.tableView reloadData];
    } authorizationFailure:^{
        NSLog(@"_____________");
    }];
}


#pragma mark - TableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.letterArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.letterArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [self.contactDic objectForKey:[self.letterArray objectAtIndex:section]];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"contactCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    NSArray *arr = [self.contactDic objectForKey:[self.letterArray objectAtIndex:indexPath.section]];
    TTPersonModel *model = [arr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.fullName ?: @"无姓名";
    NSDictionary *phoneDic = [model.mobileArray firstObject];
    cell.detailTextLabel.text = [[phoneDic allValues] firstObject] ?: @"-";
    if (model.avatarImage) {
        cell.imageView.image = model.avatarImage;
    }else {
        cell.imageView.image = [[UIImage alloc]init];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = [self.contactDic objectForKey:[self.letterArray objectAtIndex:indexPath.section]];
    TTPersonModel *model = [arr objectAtIndex:indexPath.row];
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Setter && Getter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
    }
    return _tableView;
}

- (UIButton *)button
{
    if (_button == nil) {
        _button = [[UIButton alloc]init];
        [_button setTitle:@"获取通讯录列表" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onClickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (NSMutableArray *)contactArray
{
    if (_contactArray == nil) {
        _contactArray = [NSMutableArray array];
    }
    return _contactArray;
}

- (NSArray *)letterArray
{
    if (_letterArray == nil) {
        _letterArray = [NSArray array];
    }
    return _letterArray;
}

- (NSDictionary *)contactDic
{
    if (_contactDic == nil) {
        _contactDic = [NSDictionary dictionary];
    }
    return _contactDic;
}

@end
