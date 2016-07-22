//
//  XQX_ViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/22.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "XQX_ViewController.h"
#import "LINKViewController.h"
@interface XQX_ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UITableView *XQX_TableView;
@end

@implementation XQX_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self XQX_TableViewAdd];

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

//XQX_TableView添加
-(void)XQX_TableViewAdd
{
    self.XQX_TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*8) style:UITableViewStylePlain];
    self.XQX_TableView.tableFooterView.frame = CGRectZero;
    self.XQX_TableView.tableHeaderView.frame = CGRectZero;
    self.XQX_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.XQX_TableView.backgroundColor = [UIColor whiteColor];
    self.XQX_TableView.delegate = self;
    self.XQX_TableView.dataSource = self;
    self.XQX_TableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.XQX_TableView];
}

//TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.XQX_TableView.bounds.size.height/8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"X_AreaCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    [cell  setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"县市本级(233人)";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"高亭镇";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"东沙镇";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"岱东镇";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"岱西镇";
    }else if (indexPath.row == 5){
        cell.textLabel.text = @"长涂镇";
    }else if (indexPath.row == 6){
        cell.textLabel.text = @"衢山镇";
    }else if (indexPath.row == 7){
        cell.textLabel.text = @"秀山乡";
    }
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.XQX_TableView.bounds.size.height/8-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LINKViewController *linkController = [[LINKViewController alloc]init];
    [self.navigationController pushViewController:linkController animated:YES];
    
    [self.XQX_TableView deselectRowAtIndexPath:[self.XQX_TableView indexPathForSelectedRow] animated:YES];
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
