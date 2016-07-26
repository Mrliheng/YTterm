//
//  WorkViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/20.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "WorkViewController.h"
#import "XQWorkViewController.h"
@interface WorkViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *WorkTableView;
@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标题
    self.navigationItem.title = @"工作信息";
    
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
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];//背景颜色
    [self WorkTableViewAdd];//WorkTableView添加
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
//WorkTableView添加
- (void)WorkTableViewAdd
{
    self.WorkTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*3) style:UITableViewStylePlain];
    self.WorkTableView.tableFooterView.frame = CGRectZero;
    self.WorkTableView.tableHeaderView.frame = CGRectZero;
    self.WorkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.WorkTableView.backgroundColor = [UIColor whiteColor];
    self.WorkTableView.delegate = self;
    self.WorkTableView.dataSource = self;
    self.WorkTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.WorkTableView];
    
}

//TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.WorkTableView.bounds.size.height/3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"workCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //设置cell.textLabel
    cell.textLabel.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    cell.textLabel.textColor = [UIColor blackColor];
    
    [cell.imageView setImage:[UIImage imageNamed:@"1"]];
    if (indexPath.row == 0 ) {
        cell.textLabel.text = @"水库";
    } else if (indexPath.row == 1){
        cell.textLabel.text = @"山塘";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"水闸";
    }
    cell.textLabel.tag = 1012;
    
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.WorkTableView.bounds.size.height/3-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQWorkViewController *xqWorkController = [[XQWorkViewController alloc]init];
    [self.navigationController pushViewController:xqWorkController animated:YES];
    //设置navigationItem.title(用tag值设置)
    UILabel *navLabel = (UILabel *)[self.view viewWithTag:1012];
    xqWorkController.navigationItem.title = navLabel.text;
    [self.WorkTableView deselectRowAtIndexPath:[self.WorkTableView indexPathForSelectedRow] animated:YES];
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
