//
//  XQ_XQViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/20.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "XQ_XQViewController.h"

@interface XQ_XQViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) UITableView *GYXQTableView;
@end

@implementation XQ_XQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标题
    self.navigationItem.title = @"详情";
    
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
    [self GYXQTableViewAdd];
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//GYXQTableView添加
-(void)GYXQTableViewAdd
{
    
    self.GYXQTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/32*5*2) style:UITableViewStylePlain];
    self.GYXQTableView.tableFooterView.frame = CGRectZero;
    self.GYXQTableView.tableHeaderView.frame = CGRectZero;
    self.GYXQTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.GYXQTableView.delegate = self;
    self.GYXQTableView.dataSource = self;
    self.GYXQTableView.scrollEnabled = NO; //设置tableview 不能滚动
    self.GYXQTableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [self.view addSubview:self.GYXQTableView];
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
    return self.GYXQTableView.bounds.size.height/2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"xiangqingCell"];
    cell.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell  setAccessoryType:UITableViewCellAccessoryNone];
    
    //cellLabel添加
    UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/32, self.GYXQTableView.bounds.size.height/2/5*3/22*9, self.view.bounds.size.width/16*15, self.GYXQTableView.bounds.size.height/2/5*3/22*13)];
    cellLabel.font = [UIFont systemFontOfSize:cellLabel.bounds.size.width/24];
    cellLabel.textAlignment = NSTextAlignmentLeft;
    cellLabel.textColor = [UIColor colorWithRed:0.62 green:0.62 blue:0.64 alpha:1.0];
    //自动换行
    cellLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cellLabel.numberOfLines = 0;
    [cell addSubview:cellLabel];
    
    //cellView添加
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, self.GYXQTableView.bounds.size.height/2/5*3, self.view.bounds.size.width, self.GYXQTableView.bounds.size.height/2/5*2)];
    cellView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:cellView];
    
    //cellView上的两个Label
    UILabel *cellV_Label1 = [[UILabel alloc]initWithFrame:CGRectMake(cellView.bounds.size.width/16, 0, cellView.bounds.size.width/16*3, cellView.bounds.size.height)];
    cellV_Label1.textColor = [UIColor blackColor];
    cellV_Label1.textAlignment = NSTextAlignmentCenter;
    cellV_Label1.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    [cellView addSubview:cellV_Label1];
    
    UILabel *cellV_Label2 = [[UILabel alloc]initWithFrame:CGRectMake(cellView.bounds.size.width/8*3, 0, cellView.bounds.size.width/16*3, cellView.bounds.size.height)];
    cellV_Label2.textColor = [UIColor blackColor];
    cellV_Label2.textAlignment = NSTextAlignmentCenter;
    cellV_Label2.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    [cellView addSubview:cellV_Label2];
    
    if (indexPath.row == 0) {
        cellLabel.text = @"超警戒水位(列名分别为测站名称、当前水位、超警戒值)";
        cellV_Label1.text = @"无";
        cellV_Label2.text = @"无";
    }else if (indexPath.row == 1){
        cellLabel.text = @"单站当日最大降雨量";
        cellV_Label1.text = @"岱里";
        cellV_Label2.text = @"0mm";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.GYXQTableView deselectRowAtIndexPath:[self.GYXQTableView indexPathForSelectedRow] animated:YES];
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
