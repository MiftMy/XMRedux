//
//  XMState.h
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>


// State:是对外接口，可以是一些数组或者字典。保存原始数据和所有操作数据
@interface XMState : NSObject
@property (nonatomic, strong) NSArray *itemList;

    /// 操作后的数据记录，可以不用。
@property (nonatomic, strong) NSMutableArray* allOperationList;
@end
