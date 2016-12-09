//
//  TTPersonModel.m
//  TTAddressBook
//
//  Created by Jadyn on 16/9/19.
//  Copyright © 2016年 Jadyn. All rights reserved.
//

#import "TTPersonModel.h"

@implementation TTPersonModel
- (NSMutableArray *)mobileArray
{
    if (_mobileArray == nil) {
        _mobileArray = [NSMutableArray array];
    }
    return _mobileArray;
}


- (NSMutableArray *)emailArray
{
    if (_emailArray == nil) {
        _emailArray = [NSMutableArray array];
    }
    return _emailArray;
}

- (NSMutableArray *)addressArray
{
    if (_addressArray == nil) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}



@end
