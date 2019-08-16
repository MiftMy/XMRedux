//
//  XMActionType.h
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

/// action 类型
typedef NS_ENUM(NSInteger, XMActionType) {
    XMActionTypeQueryAll = 0,   // 添加所有
    XMActionTypeAdd,            // 添加
    XMActionTypeEdit,           // 编辑
    XMActionTypeRemove          // 删除
};
