//
//  YJDXViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/22.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "YJDXViewController.h"
#import "MANViewController.h"
@interface YJDXViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) UITableView *YJDXTableView;
@end

@implementation YJDXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标题
    self.navigationItem.title = @"自定义分组";
    
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
    [self YJDXTableViewAdd];
    
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


//YJDXTableView添加
-(void)YJDXTableViewAdd
{
    self.YJDXTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*8) style:UITableViewStylePlain];
    self.YJDXTableView.tableFooterView.frame = CGRectZero;
    self.YJDXTableView.tableHeaderView.frame = CGRectZero;
    self.YJDXTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.YJDXTableView.backgroundColor = [UIColor whiteColor];
    self.YJDXTableView.delegate = self;
    self.YJDXTableView.dataSource = self;
    self.YJDXTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.YJDXTableView];
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
    return self.YJDXTableView.bounds.size.height/8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DuanXinCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    [cell  setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"县领导";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"县三防办";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"乡、镇长";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"村主任、书记";
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"地质灾害点防治负责人";
    }else if (indexPath.row == 5){
        cell.textLabel.text = @"海塘责任人";
    }else if (indexPath.row == 6){
        cell.textLabel.text = @"书库巡查员";
    }else if (indexPath.row == 7){
        cell.textLabel.text = @"海塘管理员";
    }
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.YJDXTableView.bounds.size.height/8-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MANViewController *manController = [[MANViewController alloc]init];
    [self.navigationController pushViewController:manController animated:YES];
    [self.YJDXTableView deselectRowAtIndexPath:[self.YJDXTableView indexPathForSelectedRow] animated:YES];
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
