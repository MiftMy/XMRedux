//
//  XMReducers.m
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMReducers.h"
#import "XMState.h"
#import "XMActionType.h"
#import "XMAction.h"
#import "XMToDoItem.h"
#import <JSONModel.h>

@implementation XMReducers
+ (NSArray*)reducers {
    return @[[self todoReducer], [self delReducer]];
}

// 只实现一个，后面reducer雷同
+ (XMReducerBlock)todoReducer {
    XMReducerBlock block = ^(XMState **state, XMAction *action) {
        if (state == NULL) {
            return;
        }
        XMState *newState = *state;
        // action 1 --------------
        if (action.type == XMActionTypeQueryAll) {  // 默认初始化几个
            NSMutableArray *list = [NSMutableArray array];
            for (NSDictionary *dic in action.params) {
                XMToDoItem *item = [[XMToDoItem alloc]initWithDictionary:dic];
                [list addObject:item];
            }
            newState.itemList = list;
            [newState.allOperationList addObject:list];
        }
        if (action.type == XMActionTypeAdd) {  // 添加一个
            NSMutableArray *list = [newState.itemList mutableCopy];
            NSDictionary *dic = action.params;
            XMToDoItem *item = [[XMToDoItem alloc]initWithDictionary:dic];
            [list addObject:item];
            newState.itemList = list;
            [newState.allOperationList addObject:list];
        }
        if (action.type == XMActionTypeEdit) {  // 修改
            NSMutableArray *list = [NSMutableArray arrayWithArray: newState.itemList];
            NSInteger reqID =  [[(NSDictionary *)action.params objectForKey:@"id"]integerValue];
            XMToDoItem *editItem = [self queryTodoItemWithToDoId:reqID todoList:list];
            if (editItem) {
                NSInteger index = [list indexOfObject:editItem];
                NSMutableDictionary* changeTodoDict = [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)action.params];
                [changeTodoDict setObject:[NSNumber numberWithUnsignedLong:[[NSDate new] timeIntervalSince1970]]
                                   forKey:@"todoUpdateDate"];
                /// 更新item
                NSMutableDictionary* oldModelDict = [[NSMutableDictionary alloc] initWithDictionary:[editItem toDictionary]];
                [oldModelDict setValuesForKeysWithDictionary:changeTodoDict];
                XMToDoItem* changeTodoItem  = [[[(JSONModel *)editItem class] alloc] initWithDictionary:oldModelDict error:nil];
                [list replaceObjectAtIndex:index withObject:changeTodoItem];
                newState.itemList = list;
                [newState.allOperationList addObject:list];
            }
        }
        if (action.type == XMActionTypeRemove) { // 删除
            NSMutableArray *list = [newState.itemList mutableCopy];
            NSInteger reqID =  [[(NSDictionary *)action.params objectForKey:@"id"]integerValue];
            XMToDoItem *removeItem = [self queryTodoItemWithToDoId:reqID todoList:list];
            if (removeItem) {
                [list removeObject:removeItem];
                newState.itemList = list;
                [newState.allOperationList addObject:list];
            }
        }
    };
    return block;
}

///  可以有很多个reducer， 依据业务不同，另外一个reducer，目前没事情做
+ (XMReducerBlock)delReducer {
    XMReducerBlock block = ^(XMState **state, XMAction *action) {
        if (state == NULL) {
            return;
        }
    };
    return block;
}

#pragma mark - JudgeTodoItem
+ (XMToDoItem *)queryTodoItemWithToDoId:(NSInteger)todoId todoList:(NSArray *)todoArray {
    for (XMToDoItem* todoItem in todoArray) {
        if (todoItem.todoId == todoId) {
            return todoItem;
        }
    }
    return nil;
}

@end
