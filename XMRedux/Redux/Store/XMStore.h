//
//  XMStore.h
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMAction, RACSignal;

/// 由于App中只存在唯一一个store，它保存所有的数据。直接上单例
@interface XMStore : NSObject

/// 内部state变化会通知
@property (nonatomic, strong, readonly) RACSignal *rac_observer;

+ (XMStore *)sharedInstance;

/// 执行操作
- (void)dispatchWithAction:(XMAction *)actioin;

@end
