//
//  DQXQController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/19.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "DQXQController.h"
#import "GYLBTableViewCell.h"
#import "XQ_XQViewController.h"
@interface DQXQController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *XQGYTableView;

@end

@implementation DQXQController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
    
    //小标题
    UILabel *XBTlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.height/40, 0, self.view.bounds.size.width, self.view.bounds.size.height/16)];
    XBTlabel.textColor = [UIColor blackColor];
    XBTlabel.textAlignment = NSTextAlignmentLeft;
    [XBTlabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:XBTlabel.bounds.size.height/5*2]];
    //文本设置
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"汛情概要"];
    //计算字符间隔
    NSNumber *wordSpace = [NSNumber numberWithInt:XBTlabel.bounds.size.height/20];
    //添加属性
    [attributeString addAttribute:NSKernAttributeName value:wordSpace range:NSMakeRange(0, attributeString.length)];
    XBTlabel.attributedText = attributeString;
    [self.view addSubview:XBTlabel];
    
    
    [self mainXQ];
}



//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//汛情概要内容标题
- (void)mainXQ
{
    self.XQGYTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*5) style:UITableViewStylePlain];
    self.XQGYTableView.tableFooterView.frame = CGRectZero;
    self.XQGYTableView.tableHeaderView.frame = CGRectZero;
    self.XQGYTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.XQGYTableView.backgroundColor = [UIColor whiteColor];
    self.XQGYTableView.delegate = self;
    self.XQGYTableView.dataSource = self;
    self.XQGYTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.XQGYTableView];
    
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
    return self.XQGYTableView.bounds.size.height/5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GYLBTableViewCell *cell = (GYLBTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"GYLBTableViewCell"];
    if (!cell) {
        cell = (GYLBTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"GYLBTableViewCell" owner:self options:nil]  lastObject];
    }
    
//    cell.GYLabel.font = [UIFont systemFontOfSize:self.XQGYTableView.bounds.size.height/15];
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.XQGYTableView.bounds.size.height/5-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQ_XQViewController *Details_Contorller = [[XQ_XQViewController alloc]init];
    [self.navigationController pushViewController:Details_Contorller animated:YES];
    [self.XQGYTableView deselectRowAtIndexPath:[self.XQGYTableView indexPathForSelectedRow] animated:YES];
}

@end
