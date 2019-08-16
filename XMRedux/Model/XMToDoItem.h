//
//  XMToDoItem.h
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

typedef NS_ENUM(NSInteger, XMTodoState) {
    XMTodoStateNew,
    XMTodoStateDoing,
    XMTodoStateFinish,
    XMTodoStateDelete
};

@interface XMToDoItem : JSONModel
@property (nonatomic, assign) NSInteger todoId;
@property (nonatomic, copy) NSString *todoTitle;
@property (nonatomic, assign) XMTodoState todoState;
@property (nonatomic, copy) NSNumber *todoCreateDate;
@property (nonatomic, copy) NSNumber *todoUpdateDate;

- (instancetype)initWithName:(NSString *)name;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
