//
//  XMStore.m
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMStore.h"
#import "XMReducers.h"
#import "XMState.h"
#import "XMAction.h"
#import <ReactiveObjC.h>

@interface XMStore()
/// 数据
@property (nonatomic, strong) XMState *state;
/// 数据变化观察者
@property (nonatomic, strong) RACSignal *rac_observer;
/// action执行队列
@property (nonatomic, strong) dispatch_queue_t serialQueue;
/// 所有reducer
@property (nonatomic, strong) NSArray<XMReducerBlock> *reducers;
@end


@implementation XMStore

- (instancetype)init {
    if (self = [super init]) {
        _serialQueue = dispatch_queue_create("Redux-OC Action Queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark - lazyload
- (XMState *)state {
    if (!_state) {
        _state = [[XMState alloc]init];
    }
    return _state;
}

- (RACSignal *)rac_observer {
    if (!_rac_observer) {
        _rac_observer = [RACObserve(self, state) replayLast];
    }
    return _rac_observer;
}

- (NSArray<XMReducerBlock> *)reducers {
    if (!_reducers) {
        _reducers = [XMReducers reducers];
    }
    return _reducers;
}

#pragma mark - public
+ (XMStore *)sharedInstance {
    static dispatch_once_t onceToken;
    static XMStore *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[XMStore alloc]init];
    });
    return instance;
}

/// 把消息传递给所有的reducer
- (void)dispatchWithAction:(XMAction *)actioin {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.serialQueue, ^{
        __strong typeof(self) swSelf = weakSelf;
        XMState *newState = self.state;
        for (XMReducerBlock block in swSelf.reducers) {
            block(&newState, actioin);
        }
        swSelf.state = newState;
    });
}
@end
