//
//  SetViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/20.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *SetTableView;
@property (strong,nonatomic) UIButton *ExitBT;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标题
    self.navigationItem.title = @"当前汛情";
    
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
    
    [self textViewSET];//tableview列表添加
    [self buttonSET];//button退出按钮添加
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//退出登陆
-(void)exitBT{
    
    [[UIApplication sharedApplication] performSelector:@selector(terminateWithSuccess)];
    
}
-(void)terminateWithSuccess
{
    exit(0);
}

//tableview列表添加
-(void)textViewSET
{
    self.SetTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*4) style:UITableViewStylePlain];
    self.SetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.SetTableView.backgroundColor = [UIColor whiteColor];
    self.SetTableView.delegate = self;
    self.SetTableView.dataSource = self;
    self.SetTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.SetTableView];
}

//button退出按钮添加
-(void)buttonSET
{
    self.ExitBT = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/8, self.view.bounds.size.height/5*4, self.view.bounds.size.width/4*3, self.view.bounds.size.height/16)];
    self.ExitBT.backgroundColor = [UIColor redColor];
    self.ExitBT.layer.masksToBounds = YES;
    self.ExitBT.layer.cornerRadius = self.ExitBT.bounds.size.height/6;
    [self.ExitBT setTitle:@"退出当前账号"  forState:UIControlStateNormal];
    [self.ExitBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ExitBT addTarget:self action:@selector(exitBT) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.ExitBT];
}

//TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.SetTableView.bounds.size.height/4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"detailCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:self.SetTableView.bounds.size.height/12];
    [cell  setAccessoryType:UITableViewCellAccessoryNone];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"消息提醒";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"清除缓存";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"当前版本";
        
        //副标题
        cell.detailTextLabel.text = @"最新版本:1.1.2";
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:self.SetTableView.bounds.size.height/16];
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"关于";
    }
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.SetTableView.bounds.size.height/4-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.SetTableView deselectRowAtIndexPath:[self.SetTableView indexPathForSelectedRow] animated:YES];
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
