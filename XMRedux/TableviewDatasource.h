//
//  TableviewDatasource.h
//  XMRedux
//
//  Created by Mifit on 2018/8/3.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

@interface TableviewDatasource : NSObject <UITableViewDataSource>
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (RACSubject *)reloadTableSubject;

- (void)addWithName:(NSString *)name;
- (void)deleteAtRow:(NSInteger)row;
- (void)changeAtRow:(NSInteger)row param:(NSDictionary *)param;

- (void)stateNewAtRow:(NSInteger)row;
- (void)stateDeleteAtRow:(NSInteger)row;
- (void)stateDoingAtRow:(NSInteger)row;
- (void)stateFinishAtRow:(NSInteger)row;

@end
