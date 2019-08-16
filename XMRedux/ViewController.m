//
//  ViewController.m
//  XMRedux
//
//  Created by Mifit on 2018/7/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <ReactiveObjC.h>
#import "XMAction.h"
#import "XMStore.h"

#import "TableviewDatasource.h"

@interface ViewController ()
<
UITableViewDelegate
>
{
    TableviewDatasource *datasource;
}
@property (nonatomic, strong) UITableView *tbview;
@end

@implementation ViewController

- (NSString *)loadFormatterDataString:(NSString *)string LocaleIdentifier:(NSString *)LocaleIdentifier{
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:LocaleIdentifier]];
    
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //    NSTimeInterval time =[string doubleValue]/1000;
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:[string doubleValue]];
    NSString *str= [inputFormatter stringFromDate:detailDate];
    return str;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSTimeInterval interval =  [[NSDate new]timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%.0f", interval];
    NSDate *date = [self loadFormatterDataString:timeStr LocaleIdentifier:@"nihaoba"];
    
    NSArray *params = @[@{@"name":@"mike"}, @{@"name":@"miky"}, @{@"name":@"daicy"}, @{@"name":@"dancy"}];
    XMAction *allAction = [[XMAction alloc]initWithActionType:XMActionTypeQueryAll params:params];
    [[XMStore sharedInstance]dispatchWithAction:allAction];
    
    datasource = [[TableviewDatasource alloc]initWithReuseIdentifier:@"identifier"];
    
    _tbview = [[UITableView alloc]init];
    _tbview.frame = self.view.bounds;
    [self.view addSubview:_tbview];
    _tbview.delegate = self;
    _tbview.dataSource = datasource;
//    _tbview.editing = YES;
    
    __weak typeof(self) weakSelf = self;
    [datasource.reloadTableSubject subscribeNext:^(id  _Nullable x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(self) swSelf = weakSelf;
            [swSelf.tbview reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeColor:(id)sender {
    static NSInteger val = 0;
    NSInteger type = val%4;
    if (type == 0) {
        [datasource stateDoingAtRow:0];
    }
    if (type == 1) {
        [datasource stateFinishAtRow:0];
    }
    if (type == 2) {
        [datasource stateDeleteAtRow:0];
    }
    if (type == 3) {
        [datasource stateNewAtRow:0];
    }
    val++;
}

- (IBAction)addItem:(id)sender {
    [datasource addWithName:@"hahaha"];
}

- (IBAction)delItem:(id)sender {
    [datasource deleteAtRow:0];
}

- (IBAction)changeItem:(id)sender {
    // 对着model传参
    NSDictionary *param = @{@"todoTitle":@"ssss"};
    [datasource changeAtRow:0 param:param];
}

- (IBAction)reload:(id)sender {
    [self.tbview reloadData];
}

@end
