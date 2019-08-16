//
//  TableviewDatasource.m
//  XMRedux
//
//  Created by Mifit on 2018/8/3.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "TableviewDatasource.h"
#import "ViewModel.h"
#import "TableViewCell.h"
#import "XMToDoItem.h"

#import "XMRedux.h"

@interface TableviewDatasource()
{
    NSString *_reuseIdentifier;
}
@property (nonatomic, strong) ViewModel *dtVM;
@end


@implementation TableviewDatasource
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super init]) {
        _reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dtVM.allList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_reuseIdentifier];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:_reuseIdentifier];
    }
    XMToDoItem *item =  self.dtVM.allList[indexPath.row];
    cell.textLabel.text = item.todoTitle;
    [cell updateCellWithState:item.todoState];
    return cell;
}

- (ViewModel *)dtVM {
    if (!_dtVM) {
        _dtVM = [[ViewModel alloc]init];
    }
    return _dtVM;
}

- (RACSubject *)reloadTableSubject {
    return self.dtVM.reloadTableViewSubject;
}

#pragma mark - Todo Operation
- (void)addWithName:(NSString *)name {
    XMAction *action = [[XMAction alloc]initWithActionType: XMActionTypeAdd params:@{@"name":name}];
    [[XMStore sharedInstance]dispatchWithAction:action];
}

- (void)deleteAtRow:(NSInteger)row {
    XMToDoItem* XMToDoItem = [self.dtVM.allList objectAtIndex:row];
    XMAction* deleteAction = [[XMAction alloc] initWithActionType:XMActionTypeRemove
                                                           params:@{@"id" : [NSNumber numberWithInteger:XMToDoItem.todoId]}];
    [[XMStore sharedInstance] dispatchWithAction:deleteAction];
}

- (void)changeAtRow:(NSInteger)row param:(NSDictionary *)param {
    XMToDoItem* XMToDoItem = [self.dtVM.allList objectAtIndex:row];
    NSMutableDictionary *newParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [newParam setObject:@(XMToDoItem.todoId) forKey:@"id"];
    XMAction* deleteAction = [[XMAction alloc] initWithActionType:XMActionTypeEdit params:newParam];
    [[XMStore sharedInstance] dispatchWithAction:deleteAction];
}


- (void)stateNewAtRow:(NSInteger)row {
    XMToDoItem* XMToDoItem = [self.dtVM.allList objectAtIndex:row];
    XMAction* deleteAction = [[XMAction alloc] initWithActionType:XMActionTypeEdit
                                                            params:@{@"id" : [NSNumber numberWithInteger:XMToDoItem.todoId],
                                                                     @"todoState" : [NSNumber numberWithUnsignedInteger:XMTodoStateNew]}];
    [[XMStore sharedInstance] dispatchWithAction:deleteAction];
}

- (void)stateDoingAtRow:(NSInteger)row {
    XMToDoItem* XMToDoItem = [self.dtVM.allList objectAtIndex:row];
    XMAction* deleteAction = [[XMAction alloc] initWithActionType:XMActionTypeEdit
                                                            params:@{@"id" : [NSNumber numberWithInteger:XMToDoItem.todoId],
                                                                     @"todoState" : [NSNumber numberWithUnsignedInteger:XMTodoStateDoing]}];
    [[XMStore sharedInstance] dispatchWithAction:deleteAction];
}

- (void)stateFinishAtRow:(NSInteger)row {
    XMToDoItem* XMToDoItem = [self.dtVM.allList objectAtIndex:row];
    XMAction* deleteAction = [[XMAction alloc] initWithActionType:XMActionTypeEdit
                                                            params:@{@"id" : [NSNumber numberWithInteger:XMToDoItem.todoId],
                                                                     @"todoState" : [NSNumber numberWithUnsignedInteger:XMTodoStateFinish]}];
    [[XMStore sharedInstance] dispatchWithAction:deleteAction];
}

- (void)stateDeleteAtRow:(NSInteger)row {
    XMToDoItem* XMToDoItem = [self.dtVM.allList objectAtIndex:row];
    XMAction* deleteAction = [[XMAction alloc] initWithActionType:XMActionTypeEdit
                                                           params:@{@"id" : [NSNumber numberWithInteger:XMToDoItem.todoId],
                                                                    @"todoState" : [NSNumber numberWithUnsignedInteger:XMTodoStateDelete]}];
    [[XMStore sharedInstance] dispatchWithAction:deleteAction];
}
@end
