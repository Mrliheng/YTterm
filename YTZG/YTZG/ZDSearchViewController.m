//
//  ZDSearchViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/8/10.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "ZDSearchViewController.h"

@interface ZDSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating>
@property (nonatomic,strong) UISearchController *zdSearchView;
@property (nonatomic,strong) UITableView *zdTableView;
@property (strong,nonatomic) NSMutableArray  *dataList;

@property (strong,nonatomic) NSMutableArray  *searchList;
@end

@implementation ZDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标题
    self.navigationItem.title = @"站点搜索";
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];//背景颜色
    
    
    //初始化数据
    self.dataList=[NSMutableArray arrayWithCapacity:100];
    
    for (NSInteger i=0; i<100; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld-FlyElephant",(long)i]];
    }
    
    //添加TableView
    [self zdTableViewAdd];
    //添加SearchBar
    [self zdSearchViewAdd];
    
    
}


-(void)zdSearchViewAdd
{
    _zdSearchView = [[UISearchController alloc]initWithSearchResultsController:nil];
    _zdSearchView.searchResultsUpdater = self;
    _zdSearchView.dimsBackgroundDuringPresentation = NO;
    
    _zdSearchView.hidesNavigationBarDuringPresentation = NO;
    
    _zdSearchView.searchBar.frame = CGRectMake(_zdSearchView.searchBar.frame.origin.x, _zdSearchView.searchBar.frame.origin.y, _zdSearchView.searchBar.frame.size.width, 44.0);
    
    self.zdTableView.tableHeaderView = _zdSearchView.searchBar;
}


-(void)zdTableViewAdd
{
    //添加TableView
    self.zdTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.zdTableView.tableFooterView.frame = CGRectZero;
    self.zdTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;//分割线隐藏
    self.zdTableView.backgroundColor = [UIColor whiteColor];
    self.zdTableView.delegate = self;
    self.zdTableView.dataSource = self;
    [self.view addSubview:self.zdTableView];
}

//设置区域
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.zdTableView.bounds.size.height+64)/15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.zdSearchView.active) {
        return self.searchList.count;//搜索结果
    }else{
        return self.dataList.count;//原始数据
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cellFlag";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (!self.zdSearchView.active) {
        [cell.textLabel setText:self.dataList[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.searchList[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.zdTableView deselectRowAtIndexPath:[self.zdTableView indexPathForSelectedRow] animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    NSLog(@"搜索Begin");
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//    NSLog(@"搜索End");
    return YES;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = [self.zdSearchView.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.zdTableView reloadData];
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
