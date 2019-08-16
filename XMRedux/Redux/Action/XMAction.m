//
//  XMAction.m
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMAction.h"

@interface XMAction()
@property (nonatomic, assign, readwrite) enum XMActionType type;
@property (nonatomic, strong, readwrite) id params;


@end

@implementation XMAction
- (instancetype)initWithActionType:(enum XMActionType)type params:(id)params {
    if (self = [super init]) {
        _type = type;
        _params = params;
    }
    return self;
}
@end
