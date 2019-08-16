//
//  ViewModel.m
//  XMRedux
//
//  Created by Mifit on 2018/8/3.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "ViewModel.h"
#import "XMStore.h"
#import "XMState.h"

@interface ViewModel()
@property (nonatomic, strong) RACDisposable *stateObserver;
@property (nonatomic, strong, readonly) RACSubject *reloadSignal;
@property (nonatomic, strong) NSArray *allList;

@end


@implementation ViewModel
- (instancetype)init {
    if (self = [super init]) {
        _allList = @[];
        [self bindRAC];
    }
    return self;
}

- (RACSubject *)reloadTableViewSubject {
    return _reloadSignal;
}

- (void)bindRAC {
    _reloadSignal = [RACSubject subject];
    self.stateObserver = [[XMStore sharedInstance].rac_observer subscribeNext:^(XMState *state) {
        if (![self.allList isEqualToArray:state.itemList]) {
            self.allList = [state.itemList copy];
            [self refreshAllList];
        }
    }];
}

- (void)refreshAllList {
    [self.reloadSignal sendNext:@1];
}
@end
