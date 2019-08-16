//
//  XMToDoItem.m
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMToDoItem.h"

@implementation XMToDoItem
- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _todoTitle = name;
        _todoId = [[NSDate new]timeIntervalSince1970];
        _todoCreateDate = [NSNumber numberWithUnsignedInteger:_todoId];
        _todoState = XMTodoStateNew;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        _todoTitle = dic[@"name"];
        _todoId = [[NSDate new]timeIntervalSince1970];
        _todoCreateDate = [NSNumber numberWithUnsignedInteger:_todoId];
        _todoState = XMTodoStateNew;
    }
    return self;
}
@end
