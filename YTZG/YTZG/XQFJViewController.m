//
//  XQFJViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/25.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "XQFJViewController.h"
#import "SXFJViewController.h"
@interface XQFJViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *XQFJTableView;
@end

@implementation XQFJViewController

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
    [self XQFJLabelAdd];//XQFJLabel添加
    [self XQFJTableViewAdd];//XQFJTableView添加
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)XQFJLabelAdd
{
    int i;
    for (i=0; i<3; i++) {
        UILabel *XQFJLabel = [[UILabel alloc]init];
        XQFJLabel.frame = CGRectMake(self.view.bounds.size.width/32+self.view.bounds.size.width/32*11*i, 0, self.view.bounds.size.width/32*7, self.view.bounds.size.height/16);
        XQFJLabel.textAlignment = NSTextAlignmentCenter;
        XQFJLabel.textColor = [UIColor blackColor];
        XQFJLabel.font = [UIFont systemFontOfSize:XQFJLabel.bounds.size.height/3];
        [self.view addSubview:XQFJLabel];
        if (i==0) {
            XQFJLabel.text = @"名称";
        }else if(i==1){
            XQFJLabel.text = @"类型";
        }else if(i==2){
            XQFJLabel.text = @"等级";
        }
    }
}

-(void)XQFJTableViewAdd
{
    self.XQFJTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/16*3) style:UITableViewStylePlain];
    self.XQFJTableView.tableFooterView.frame = CGRectZero;
    self.XQFJTableView.tableHeaderView.frame = CGRectZero;
    self.XQFJTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.XQFJTableView.backgroundColor = [UIColor whiteColor];
    self.XQFJTableView.delegate = self;
    self.XQFJTableView.dataSource = self;
    self.XQFJTableView.scrollEnabled =NO; //设置tableview 不能滚动
    [self.view addSubview:self.XQFJTableView];
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
    return self.XQFJTableView.bounds.size.height/3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"XQFJCell"];
    [cell  setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    //cell上label添加
    int j;
    for (j=0; j<3; j++) {
        UILabel *XQFJCellLabel = [[UILabel alloc]init];
        XQFJCellLabel.frame = CGRectMake(self.view.bounds.size.width/32+self.view.bounds.size.width/32*11*j, 0, self.view.bounds.size.width/32*7, self.view.bounds.size.height/16);
        XQFJCellLabel.textAlignment = NSTextAlignmentCenter;
        XQFJCellLabel.textColor = [UIColor blackColor];
        XQFJCellLabel.font = [UIFont systemFontOfSize:XQFJCellLabel.bounds.size.height/5*2];
        [cell addSubview:XQFJCellLabel];
        if (j==0) {
            XQFJCellLabel.text = @"高亭镇";
            XQFJCellLabel.tag = 1006;
        }else if(j==1){
            XQFJCellLabel.text = @"崩塌";
        }else if(j==2){
            XQFJCellLabel.text = @"小型";
        }
    }
    
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.XQFJTableView.bounds.size.height/3-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXFJViewController *sxfjController = [[SXFJViewController alloc]init];
    [self.navigationController pushViewController:sxfjController animated:YES];
    //设置navigationItem.title(用tag值设置)
    UILabel *navLabel = (UILabel *)[self.view viewWithTag:1006];
    sxfjController.navigationItem.title = navLabel.text;
    [self.XQFJTableView deselectRowAtIndexPath:[self.XQFJTableView indexPathForSelectedRow] animated:YES];
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
