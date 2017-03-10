//
//  ViewController.m
//  XmlToOriginalo
//
//  Created by 高赛 on 2017/3/10.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "ViewController.h"
#import "XMLEngine.h"
#import "FormControlModel.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        XMLEngine *xmlEngine = [XMLEngine shareXMLEngine];
        [xmlEngine analysisXMLFile:@"CQFYTest.xml"];
        _dataArr = [NSMutableArray arrayWithArray:xmlEngine.dataArr];
    }
    return _dataArr;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self.view addSubview:self.tableView];
//    XMLEngine *xmlEngine = [XMLEngine shareXMLEngine];
//    [xmlEngine analysisXMLFile:@"CQFYTest.xml"];
//    NSLog(@"%@",xmlEngine.dataArr);
//    [xmlEngine analysisXMLFile:@"formTest.xml"];
//    NSLog(@"%@",xmlEngine.dataArr);
    
}

#pragma tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dataArr[section];
    if ([self isType:section]) {
        return arr.count - 1;
    } else {
        return arr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"as"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"as"];
    }
    
    FormControlModel *model = [[FormControlModel alloc] init];
    if ([self isType:indexPath.section]) {
        model = self.dataArr[indexPath.section][indexPath.row + 1];
    } else {
        model = self.dataArr[indexPath.section][indexPath.row];
    }
    cell.textLabel.text = model.formControlName;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    if ([self isType:section]) {
        FormControlModel *model = self.dataArr[section][0];
        view.backgroundColor = [UIColor grayColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
        label.text = model.formControlName;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
    } else {
        
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self isType:section]) {
        return 30;
    } else {
        return 0;
    }
}

- (BOOL)isType:(NSInteger)index {
    
    NSArray *arr = self.dataArr[index];
    FormControlModel *model = arr.firstObject;
    if ([model.formControlType isEqualToString:@"10"]) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
