//
//  XMState.m
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMState.h"

@interface XMState()<NSCopying>

@end

@implementation XMState

- (NSMutableArray *)allOperationList {
    if (!_allOperationList) {
        _allOperationList = [[NSMutableArray alloc] init];
    }
    return _allOperationList;
}
@end
