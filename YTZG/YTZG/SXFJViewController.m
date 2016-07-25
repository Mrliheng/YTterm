//
//  SXFJViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/25.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "SXFJViewController.h"

@interface SXFJViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView *SXFJTableView;
@end

@implementation SXFJViewController

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
    
    [self SXFJTableViewAdd];//SXFJTableView添加
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)SXFJTableViewAdd
{
    self.SXFJTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.SXFJTableView.tableFooterView.frame = CGRectZero;
    self.SXFJTableView.tableHeaderView.frame = CGRectZero;
    self.SXFJTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.SXFJTableView.backgroundColor = [UIColor whiteColor];
    self.SXFJTableView.delegate = self;
    self.SXFJTableView.dataSource = self;
    self.SXFJTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.SXFJTableView];
}

//TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height/16;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SXFJCell"];
    cell.userInteractionEnabled = NO;//禁止cell点击
    UILabel *label_SM = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/32*15, self.view.bounds.size.height/16)];
    label_SM.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    label_SM.textColor = [UIColor blackColor];
    label_SM.textAlignment = NSTextAlignmentCenter;
    [cell addSubview:label_SM];
    
    UILabel *label_SZ = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/32*17,0 , self.view.bounds.size.width/32*15, self.view.bounds.size.height/16)];
    label_SZ.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    label_SZ.textColor = [UIColor colorWithRed:0.65 green:0.66 blue:0.68 alpha:1.0];
    label_SZ.textAlignment = NSTextAlignmentLeft;
    label_SZ.lineBreakMode = NSLineBreakByWordWrapping;
    label_SZ.numberOfLines = 0;
    if (label_SZ.numberOfLines !=1) {
        label_SZ.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    }
    [cell addSubview:label_SZ];
    
    [cell  setAccessoryType:UITableViewCellAccessoryNone];
    if (indexPath.row == 0) {
        label_SM.text = @"名称";
        label_SZ.text = @"高亭镇闸口社区光明路44号边坡治理";
    }else if (indexPath.row == 1){
        label_SM.text = @"所在行政区划名称";
        label_SZ.text = self.navigationItem.title;
    }else{
        label_SM.text = @"类型";
        label_SZ.text = @"崩塌";
    }
    
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.SXFJTableView deselectRowAtIndexPath:[self.SXFJTableView indexPathForSelectedRow] animated:YES];
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
