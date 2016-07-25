//
//  XQWorkViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/25.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "XQWorkViewController.h"
#import "XQWAreaViewController.h"

@interface XQWorkViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *XQWorkTableView;
@end

@implementation XQWorkViewController

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
    [self XQWorkLabelAdd];//XQWorkLabel添加
    [self XQWorkTableViewAdd];//XQWorkTableView添加
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)XQWorkLabelAdd
{
    int i;
    for (i=0; i<3; i++) {
        UILabel *XQWorkLabel = [[UILabel alloc]init];
        XQWorkLabel.frame = CGRectMake(self.view.bounds.size.width/32+self.view.bounds.size.width/32*11*i, 0, self.view.bounds.size.width/32*7, self.view.bounds.size.height/16);
        XQWorkLabel.textAlignment = NSTextAlignmentCenter;
        XQWorkLabel.textColor = [UIColor blackColor];
        XQWorkLabel.font = [UIFont systemFontOfSize:XQWorkLabel.bounds.size.height/3];
        [self.view addSubview:XQWorkLabel];
        if (i==0) {
            XQWorkLabel.text = @"名称";
        }else if(i==1){
            XQWorkLabel.text = @"所属流域";
        }else if(i==2){
            XQWorkLabel.text = @"所属乡镇";
        }
    }
}

-(void)XQWorkTableViewAdd
{
    self.XQWorkTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*3) style:UITableViewStylePlain];
    self.XQWorkTableView.tableFooterView.frame = CGRectZero;
    self.XQWorkTableView.tableHeaderView.frame = CGRectZero;
    self.XQWorkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.XQWorkTableView.backgroundColor = [UIColor whiteColor];
    self.XQWorkTableView.delegate = self;
    self.XQWorkTableView.dataSource = self;
    self.XQWorkTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.XQWorkTableView];
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
    return self.XQWorkTableView.bounds.size.height/3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"XQWorkCell"];
    [cell  setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    //cell上label添加
    int j;
    for (j=0; j<3; j++) {
        UILabel *XQWorkCellLabel = [[UILabel alloc]init];
        XQWorkCellLabel.frame = CGRectMake(self.view.bounds.size.width/32+self.view.bounds.size.width/32*11*j, 0, self.view.bounds.size.width/32*7, self.view.bounds.size.height/16);
        XQWorkCellLabel.textAlignment = NSTextAlignmentCenter;
        XQWorkCellLabel.textColor = [UIColor blackColor];
        XQWorkCellLabel.font = [UIFont systemFontOfSize:XQWorkCellLabel.bounds.size.height/5*2];
        [cell addSubview:XQWorkCellLabel];
        if (j==0) {
            XQWorkCellLabel.text = @"大沙河水库";
            XQWorkCellLabel.tag = 1005;
        }else if(j==1){
            XQWorkCellLabel.text = @"－－";
        }else if(j==2){
            XQWorkCellLabel.text = @"长涂镇";
        }
    }
    
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.XQWorkTableView.bounds.size.height/3-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XQWAreaViewController *xqwaController = [[XQWAreaViewController alloc]init];
    [self.navigationController pushViewController:xqwaController animated:YES];
    //设置navigationItem.title(用tag值设置)
    UILabel *navLabel = (UILabel *)[self.view viewWithTag:1005];
    xqwaController.navigationItem.title = navLabel.text;
    [self.XQWorkTableView deselectRowAtIndexPath:[self.XQWorkTableView indexPathForSelectedRow] animated:YES];
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
