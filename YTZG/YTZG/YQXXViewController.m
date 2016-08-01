//
//  YQXXViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/21.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "YQXXViewController.h"
#import "YLViewController.h"

@interface YQXXViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIScrollView *YQXX_ScrollView;//为了能向滑动
@property (strong,nonatomic) UIScrollView *zdmcScrollView;
@property (strong,nonatomic) UITableView *zdmcTableView;//站点名称
@property (strong,nonatomic) UITableView *YQXX_TableView;//添加列表信息，能够纵向滑动
@property (nonatomic) float JX_label;//label之间的距离
@property (nonatomic) float labelWidth;//label的宽度
@end

@implementation YQXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标题
    self.navigationItem.title = @"雨情信息";
    
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
    
    //设置搜索按钮
    UIButton *SearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    SearchButton.frame = CGRectMake(0, 0, 20, 20);
    [SearchButton setImage:[UIImage imageNamed:@"search-icon"] forState:UIControlStateNormal];
    [SearchButton addTarget:self action:@selector(SearchSet) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *SearchNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:SearchButton];
    self.navigationItem.rightBarButtonItem = SearchNavigationItem;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];//背景颜色
    
    _JX_label = self.view.bounds.size.width/16;//label之间的距离
    _labelWidth = self.view.bounds.size.width/64*15;//label的宽度
    
    //设置zdmcScrollView
    self.zdmcScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _JX_label+_labelWidth, self.view.bounds.size.height)];
    self.zdmcScrollView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    self.zdmcScrollView.showsHorizontalScrollIndicator = NO;
    self.zdmcScrollView.showsVerticalScrollIndicator = NO;//隐藏滑动条
    self.zdmcScrollView.contentSize = CGSizeMake(0, 0);//禁止竖直方向滑动
    self.zdmcScrollView.bounces = NO;
    [self.view addSubview:self.zdmcScrollView];
    
    //设置YQXX_ScrollView
    self.YQXX_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(_JX_label+_labelWidth, 0, self.view.bounds.size.width/4*5, self.view.bounds.size.height)];
    self.YQXX_TableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    self.YQXX_ScrollView.showsHorizontalScrollIndicator = NO;
    self.YQXX_ScrollView.showsVerticalScrollIndicator = NO;//隐藏滑动条
    self.YQXX_ScrollView.contentSize = CGSizeMake(self.view.bounds.size.width/2*3, 0);//禁止竖直方向滑动
    self.YQXX_ScrollView.bounces = NO;
    [self.view addSubview:self.YQXX_ScrollView];
    
    
    
    //Label
    //“站点名称”Label的添加
    UILabel *zdmcLabel = [[UILabel alloc]initWithFrame:CGRectMake(_JX_label, 0, _labelWidth, self.view.bounds.size.height/16)];
    zdmcLabel.textColor = [UIColor blackColor];
    zdmcLabel.textAlignment = NSTextAlignmentCenter;
    zdmcLabel.font = [UIFont systemFontOfSize:zdmcLabel.bounds.size.height/22*7];
    [self.zdmcScrollView addSubview:zdmcLabel];
    zdmcLabel.text = @"站点名称";
    //YQXX_ScrollView上添加label
    
    
    int i;
    for (i = 0; i<3; i++) {
        UILabel *YQXX_label = [[UILabel alloc]initWithFrame:CGRectMake(_JX_label*(i+1)+_labelWidth*i, 0, _labelWidth, self.view.bounds.size.height/16)];
        YQXX_label.textColor = [UIColor blackColor];
        YQXX_label.textAlignment = NSTextAlignmentCenter;
        YQXX_label.font = [UIFont systemFontOfSize:YQXX_label.bounds.size.height/22*7];
        [self.YQXX_ScrollView addSubview:YQXX_label];
        if (i == 0)
        {
            YQXX_label.text = @"1h雨量(mm)";
        }else if (i == 1)
        {
            YQXX_label.text = @"3h雨量(mm)";
        }else if (i == 2)
        {
            YQXX_label.text = @"今日雨量(mm)";
        }
    }
    
    //设置YQXX_TableView,并添加在YQXX_ScrollView上
    self.YQXX_TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.YQXX_ScrollView.bounds.size.width, self.view.bounds.size.height/16*5) style:UITableViewStylePlain];
    self.YQXX_TableView.tableFooterView.frame = CGRectZero;
    self.YQXX_TableView.tableHeaderView.frame = CGRectZero;
    self.YQXX_TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.YQXX_TableView.backgroundColor = [UIColor whiteColor];
    self.YQXX_TableView.delegate = self;
    self.YQXX_TableView.dataSource = self;
    [self.YQXX_ScrollView addSubview:self.YQXX_TableView];
    
    //设置zdmcTableView,并添加在View上
    self.zdmcTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.YQXX_ScrollView.frame.origin.x, self.view.bounds.size.height/16*5) style:UITableViewStylePlain];
    self.zdmcTableView.tableFooterView.frame = CGRectZero;
    self.zdmcTableView.tableHeaderView.frame = CGRectZero;
    self.zdmcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zdmcTableView.backgroundColor = [UIColor whiteColor];
    self.zdmcTableView.delegate = self;
    self.zdmcTableView.dataSource = self;
    [self.zdmcScrollView addSubview:self.zdmcTableView];
    
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//搜索设置
-(void)SearchSet
{
}


//TableView代理
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
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
    return self.YQXX_TableView.bounds.size.height/5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ImageOnRightCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    if (tableView == self.YQXX_TableView) {
        //设置YQXX_TableView上cell设置
        int j;
        for (j = 0; j<3; j++) {
            UILabel *YQXX_labelCell = [[UILabel alloc]initWithFrame:CGRectMake(_JX_label*(j+1)+_labelWidth*j, 0, _labelWidth, self.view.bounds.size.height/16-1)];
            YQXX_labelCell.textColor = [UIColor blackColor];
            YQXX_labelCell.textAlignment = NSTextAlignmentCenter;
            YQXX_labelCell.font = [UIFont systemFontOfSize:YQXX_labelCell.bounds.size.height/5*2];
            [cell.contentView addSubview:YQXX_labelCell];
            if (j == 0)
            {
                YQXX_labelCell.text = @"0";
            }else if (j == 1)
            {
                YQXX_labelCell.text = @"0";
            }else if (j == 2)
            {
                YQXX_labelCell.text = @"0";
            }
        }
    } else if (tableView == self.zdmcTableView) {
        //设置YzdmcTableView上cell设置
        UILabel *zdmcLabelCell = [[UILabel alloc]initWithFrame:CGRectMake(_JX_label, 0, _labelWidth, self.view.bounds.size.height/16-1)];
        zdmcLabelCell.textColor = [UIColor blackColor];
        zdmcLabelCell.textAlignment = NSTextAlignmentCenter;
        zdmcLabelCell.font = [UIFont systemFontOfSize:zdmcLabelCell.bounds.size.height/5*2];
        [cell.contentView addSubview:zdmcLabelCell];
        zdmcLabelCell.text = @"名称站点";
        zdmcLabelCell.tag = 1001;
    }
    
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.YQXX_TableView.bounds.size.height/5-1, self.YQXX_TableView.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YLViewController *ylController = [[YLViewController alloc]init];
    [self.navigationController pushViewController:ylController animated:YES];
    UILabel *areaLabel = (UILabel *)[self.view viewWithTag:1001];
    ylController.navigationItem.title = [areaLabel.text stringByAppendingString:@"雨量柱状图"];
    if ([tableView isEqual:_YQXX_TableView]) {
        [self.zdmcTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    } else {
        [self.YQXX_TableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_zdmcTableView]) {
        self.YQXX_TableView.contentOffset = _zdmcTableView.contentOffset;
    } else {
        self.zdmcTableView.contentOffset = _YQXX_TableView.contentOffset;
    }
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
