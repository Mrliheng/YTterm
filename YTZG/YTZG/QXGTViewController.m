//
//  QXGTViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/22.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "QXGTViewController.h"
#import "QXDHViewController.h"
@interface QXGTViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) UITableView *QXGTTableView;

@end

@implementation QXGTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标题
    self.navigationItem.title = @"防汛救灾";
    
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
    [self QXGTTableViewAdd];
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}


//QXGTTableView添加
- (void)QXGTTableViewAdd
{
    self.QXGTTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*5) style:UITableViewStylePlain];
    self.QXGTTableView.tableFooterView.frame = CGRectZero;
    self.QXGTTableView.tableHeaderView.frame = CGRectZero;
    self.QXGTTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.QXGTTableView.backgroundColor = [UIColor whiteColor];
    self.QXGTTableView.delegate = self;
    self.QXGTTableView.dataSource = self;
    self.QXGTTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.QXGTTableView];
    
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
    return self.QXGTTableView.bounds.size.height/5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = @"QXGTCell";
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
        cell.textLabel.text = @"天气预报";
    } else if (indexPath.row == 1){
        cell.textLabel.text = @"一小时降雨预报";
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"三小时降雨预报";
    }else if (indexPath.row == 3){
        cell.textLabel.text = @"卫星云图";
    }else{
        cell.textLabel.text = @"气象雷达";
    }
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.QXGTTableView.bounds.size.height/5-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QXDHViewController *qxdhViewController = [[QXDHViewController alloc]init];
    [self.navigationController pushViewController:qxdhViewController animated:YES];
//    qxdhViewController.navigationItem.title = [NSString stringWithFormat:@"%@",[tableView.visibleCells objectAtIndex:indexPath.row].textLabel.text];
    [self.QXGTTableView deselectRowAtIndexPath:[self.QXGTTableView indexPathForSelectedRow] animated:YES];
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
