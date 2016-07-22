//
//  TXLViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/22.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "TXLViewController.h"
#import "XQX_ViewController.h"
@interface TXLViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *TXLTableView;
@end

@implementation TXLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标题
    self.navigationItem.title = @"通讯录";
    
    //设置返回按钮
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 50, 20);
    [backButton setImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.textColor = [UIColor whiteColor];
    backButton.titleLabel.font = [UIFont systemFontOfSize:12];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    [backButton addTarget:self action:@selector(touchPop) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backNavigationItem;
    
    //设置搜索按钮
    UIButton *SearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    SearchButton.frame = CGRectMake(0, 0, 20, 20);
    [SearchButton setImage:[UIImage imageNamed:@"search-icon"] forState:UIControlStateNormal];
    [SearchButton addTarget:self action:@selector(SearchSet) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *SearchNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:SearchButton];
    self.navigationItem.rightBarButtonItem = SearchNavigationItem;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];//背景颜色
    [self TXLTableViewAdd];
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
-(void)SearchSet
{
}
//TXLTableView添加
-(void)TXLTableViewAdd
{
    self.TXLTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16) style:UITableViewStylePlain];
    self.TXLTableView.tableFooterView.frame = CGRectZero;
    self.TXLTableView.tableHeaderView.frame = CGRectZero;
    self.TXLTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.TXLTableView.backgroundColor = [UIColor whiteColor];
    self.TXLTableView.delegate = self;
    self.TXLTableView.dataSource = self;
    self.TXLTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.TXLTableView];
}

//TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.TXLTableView.bounds.size.height/1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AreaCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    [cell  setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"岱山县";
        cell.textLabel.tag = 1003;
    }
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.TXLTableView.bounds.size.height/1-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQX_ViewController *xqx_Controller = [[XQX_ViewController alloc]init];
    [self.navigationController pushViewController:xqx_Controller animated:YES];
    UILabel *xqx_nav = (UILabel *)[self.view viewWithTag:1003];
    xqx_Controller.navigationItem.title = xqx_nav.text;
    [self.TXLTableView deselectRowAtIndexPath:[self.TXLTableView indexPathForSelectedRow] animated:YES];
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
