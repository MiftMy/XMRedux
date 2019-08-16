//
//  TableViewCell.m
//  XMRedux
//
//  Created by Mifit on 2018/8/3.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateCellWithState:(XMTodoState)state {
    NSString *subTitle = nil;
    UIColor *subTitleColor = nil;
    switch (state) {
        case XMTodoStateNew:
            subTitle = @"New";
            subTitleColor = [UIColor blueColor];
            break;
        case XMTodoStateDoing:
            subTitle = @"Doing";
            subTitleColor = [UIColor orangeColor];
            break;
        case XMTodoStateFinish:
            subTitle = @"Finish";
            subTitleColor = [UIColor greenColor];
            break;
        case XMTodoStateDelete:
            subTitle = @"Delete";
            subTitleColor = [UIColor redColor];
            break;
        default:
            break;
    }
    self.detailTextLabel.text = subTitle;
    self.detailTextLabel.textColor = subTitleColor;
}
@end
