//
//  MANViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/22.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "MANViewController.h"

@interface MANViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *MANTableView;
@end

@implementation MANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //标题设置
    self.navigationItem.title = @"人员确认";
    
    //设置返回按钮
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 25, 20);
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    backButton.titleLabel.textColor = [UIColor whiteColor];
    backButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [backButton addTarget:self action:@selector(touchPop) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    //设置搜索按钮
    UIButton *TureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    TureButton.frame = CGRectMake(0, 0, 25, 20);
    [TureButton setTitle:@"确定" forState:UIControlStateNormal];
    TureButton.titleLabel.textColor = [UIColor whiteColor];
    TureButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [TureButton addTarget:self action:@selector(TureSet) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *TureNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:TureButton];
    self.navigationItem.rightBarButtonItem = TureNavigationItem;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];//背景颜色
    
    [self MANTableViewAdd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//搜索设置
-(void)TureSet
{
}

//MANTableView添加
- (void)MANTableViewAdd
{
    self.MANTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*2) style:UITableViewStylePlain];
    self.MANTableView.tableFooterView.frame = CGRectZero;
    self.MANTableView.tableHeaderView.frame = CGRectZero;
    self.MANTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.MANTableView.backgroundColor = [UIColor whiteColor];
    self.MANTableView.delegate = self;
    self.MANTableView.dataSource = self;
    self.MANTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.MANTableView];
}

//TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.MANTableView.bounds.size.height/2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    [cell  setAccessoryType:UITableViewCellAccessoryNone];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"薛鹏举";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"夏昊";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.MANTableView deselectRowAtIndexPath:[self.MANTableView indexPathForSelectedRow] animated:YES];
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
