//
//  ViewModel.h
//  XMRedux
//
//  Created by Mifit on 2018/8/3.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface ViewModel : NSObject
@property (nonatomic, strong, readonly) NSArray *allList;

/// 被动刷新信号
- (RACSubject *)reloadTableViewSubject;
@end
