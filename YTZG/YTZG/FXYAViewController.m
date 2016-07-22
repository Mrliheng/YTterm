//
//  FXYAViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/22.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "FXYAViewController.h"
#import "YAXQViewController.h"
@interface FXYAViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *FXYATableView;
@end

@implementation FXYAViewController

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
    [self FXYATableViewAdd];
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


//FXYATableView添加
-(void)FXYATableViewAdd
{
    self.FXYATableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*2) style:UITableViewStylePlain];
    self.FXYATableView.tableFooterView.frame = CGRectZero;
    self.FXYATableView.tableHeaderView.frame = CGRectZero;
    self.FXYATableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.FXYATableView.backgroundColor = [UIColor whiteColor];
    self.FXYATableView.delegate = self;
    self.FXYATableView.dataSource = self;
    self.FXYATableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.FXYATableView];
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
    return self.FXYATableView.bounds.size.height/2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AreaCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    [cell  setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"岱山县山洪灾害防御预案";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"岱山县山洪灾害防治项目山洪灾害防御预案";
    }
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.FXYATableView.bounds.size.height/2-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAXQViewController *yaxqController = [[YAXQViewController alloc]init];
    [self.navigationController pushViewController:yaxqController animated:YES];
    [self.FXYATableView deselectRowAtIndexPath:[self.FXYATableView indexPathForSelectedRow] animated:YES];
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
