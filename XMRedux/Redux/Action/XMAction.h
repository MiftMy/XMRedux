//
//  XMAction.h
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMActionType.h"

// action是传递数据的唯一通道，各种action高度统一。这里描述为type和params两个属性的Item。
@interface XMAction : NSObject
@property (nonatomic, assign, readonly) enum XMActionType type;
@property (nonatomic, strong, readonly) id params;// 一般是一个字典，model的字典

- (instancetype)initWithActionType:(enum XMActionType)type params:(id)params;
@end
