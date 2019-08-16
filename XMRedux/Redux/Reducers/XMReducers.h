//
//  XMReducers.h
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMAction, XMState;
/// 二级指针，state会改变
typedef void(^XMReducerBlock)(XMState **state, XMAction *action);


// Reducer是整个的重点部分，它处理action传递来的信息，根据type分类交给不同的reducer来处理，并将处理完的数据更新到store 
@interface XMReducers : NSObject
+ (NSArray*)reducers;
@end
