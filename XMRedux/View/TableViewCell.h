//
//  TableViewCell.h
//  XMRedux
//
//  Created by Mifit on 2018/8/3.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XMToDoItem.h"

@interface TableViewCell : UITableViewCell
- (void)updateCellWithState:(XMTodoState)state;
@end
