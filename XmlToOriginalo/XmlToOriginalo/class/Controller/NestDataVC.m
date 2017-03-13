//
//  NestDataVC.m
//  XmlToOriginalo
//
//  嵌套数据列表控制器
//
//  Created by 高赛 on 2017/3/13.
//  Copyright © 2017年 高赛. All rights reserved.
//

#import "NestDataVC.h"
#import "NestDataCell.h"
#import "FormControlModel.h"

@interface NestDataVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *selectNameStr;

@end

@implementation NestDataVC

#pragma 懒加载
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
#pragma 生命周期
- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
    [self setNav];
}
#pragma 自定义方法
- (void)setNav {
    
    self.title = self.nameTitle;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBtn)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}
- (void)clickLeftBtn {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickRightBtn {
    if (self.isSingle) {
        NSMutableArray *arr = [NSMutableArray array];
        for (FormControlCateModel *model in self.dataArr) {
            if (model.isSelect) {
                [arr addObject:model.formControlCateName];
            }
        }
        self.selectNameStr = [arr componentsJoinedByString:@","];
        self.myBlock(self.selectNameStr);
    } else {
        self.myBlock(self.selectNameStr);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NestDataCell *cell = [NestDataCell nestDataCellTableView:tableView withIdentifier:@"formControlData"];
    cell.isSingle = self.isSingle;
    FormControlCateModel *model = self.dataArr[indexPath.row];
    if (!self.isSingle) {
        if ([self.selectNameStr isEqualToString:model.formControlCateName]) {
            model.isSelect = YES;
        } else {
            model.isSelect = NO;
        }
    }
    cell.model = model;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FormControlCateModel *model = self.dataArr[indexPath.row];
    if (self.isSingle) {
        model.isSelect = !model.isSelect;
    } else {
        self.selectNameStr = model.formControlCateName;
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
