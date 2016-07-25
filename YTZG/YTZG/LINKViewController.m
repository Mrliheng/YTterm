//
//  LINKViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/22.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "LINKViewController.h"
#import "ChineseString.h"

@interface LINKViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSMutableArray *indexArray;
//设置每个section下的cell内容
@property(nonatomic,retain)NSMutableArray *LetterResultArr;

@property(nonatomic,strong)UITableView *LINKTableView;
@end

@implementation LINKViewController
@synthesize indexArray;
@synthesize LetterResultArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标题
    self.navigationItem.title = @"乡镇本级(92人)";
    
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
    [self LINKTableViewAdd];//LINKTableView添加
    
    
    //联系人名单
    NSArray *stringsToSort=[NSArray arrayWithObjects:
                            @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
                            @"开源技术",@"社区",@"开发者",@"传播",
                            @"2014",@"2013",@"100",@"中国",@"暑假作业",
                            @"键盘", @"鼠标",@"hello",@"world",
                            nil];
    
    //首字母分组个数
    self.indexArray = [ChineseString IndexArray:stringsToSort];
    //每组元素个数
    self.LetterResultArr = [ChineseString LetterSortArray:stringsToSort];
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

//LINKTableView添加
-(void)LINKTableViewAdd
{
    self.LINKTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.LINKTableView.tableFooterView.frame = CGRectZero;
    self.LINKTableView.tableHeaderView.frame = CGRectZero;
    self.LINKTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线隐藏
    self.LINKTableView.backgroundColor = [UIColor whiteColor];
    self.LINKTableView.delegate = self;
    self.LINKTableView.dataSource = self;
    [self.view addSubview:self.LINKTableView];
}

//TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.LetterResultArr objectAtIndex:section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height/11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"linkCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:self.view.bounds.size.height/40];
    [cell  setAccessoryType:UITableViewCellAccessoryNone];
    
    //联系人头像添加
    UIImageView *LinkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/32, self.view.bounds.size.height/11/6, self.view.bounds.size.height/11/3*2, self.view.bounds.size.height/11/3*2)];
    [LinkImageView setImage:[UIImage imageNamed:@"9"]];
    [cell addSubview:LinkImageView];
    //联系人名字
    UILabel *LNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/32*3+self.view.bounds.size.height/11/3*2, self.view.bounds.size.height/11/6, self.view.bounds.size.width/8*3, self.view.bounds.size.height/11/3)];
    LNameLabel.font = [UIFont systemFontOfSize:LNameLabel.bounds.size.height/3*2];
    LNameLabel.textColor = [UIColor colorWithRed:0.44 green:0.49 blue:0.57 alpha:1.0];
    LNameLabel.textAlignment = NSTextAlignmentLeft;
    LNameLabel.text = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    [cell addSubview:LNameLabel];
    //联系人电话
    UILabel *LTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/32*3+self.view.bounds.size.height/11/3*2, self.view.bounds.size.height/11/2, self.view.bounds.size.width/8*3, self.view.bounds.size.height/11/3)];
    LTelLabel.font = [UIFont systemFontOfSize:LNameLabel.bounds.size.height/3*2];
    LTelLabel.textColor = [UIColor colorWithRed:0.44 green:0.49 blue:0.57 alpha:1.0];
    LTelLabel.textAlignment = NSTextAlignmentLeft;
    LTelLabel.text = @"139 1234 1333";
    LTelLabel.tag = 1111;
    [cell addSubview:LTelLabel];
    //联系人职务
    UILabel *LZWLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/16*9, self.view.bounds.size.height/11/6, self.view.bounds.size.width/8*3, self.view.bounds.size.height/11/3)];
    LZWLabel.font = [UIFont systemFontOfSize:LNameLabel.bounds.size.height/3*2];
    LZWLabel.textColor = [UIColor colorWithRed:0.44 green:0.49 blue:0.57 alpha:1.0];
    LZWLabel.textAlignment = NSTextAlignmentRight;
    LZWLabel.text = @"水库巡查员";
    [cell addSubview:LZWLabel];
    //联系人
    UILabel *LLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/16*9, self.view.bounds.size.height/11/2, self.view.bounds.size.width/8*3, self.view.bounds.size.height/11/3)];
    LLabel.font = [UIFont systemFontOfSize:LNameLabel.bounds.size.height/3*2];
    LLabel.textColor = [UIColor colorWithRed:0.44 green:0.49 blue:0.57 alpha:1.0];
    LLabel.textAlignment = NSTextAlignmentRight;
    LLabel.text = @"－－";
    [cell addSubview:LLabel];
    
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/11-1, self.view.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *telLabel = (UILabel *)[self.view viewWithTag:1111];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:telLabel.text message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    // 创建按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"呼叫" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSString *telStr = [NSString stringWithFormat:@"tel://%@",telLabel.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];//拨打电话(模拟器不行，必须真机测试)
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
    }];
    // 添加按钮 将按钮添加到UIAlertController对象上
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
    [self presentViewController:alertController animated:YES completion:nil];

    [self.LINKTableView deselectRowAtIndexPath:[self.LINKTableView indexPathForSelectedRow] animated:YES];
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
