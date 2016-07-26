//
//  SQXXViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/21.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "SQXXViewController.h"
#import "SW_ViewController.h"
@interface SQXXViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UILabel *SQXXLabel;//列表上方标注
@property (strong,nonatomic) UITableView *SQXXTableView;
@property (strong,nonatomic) UIButton *GCButton85;//85高程
@property (strong,nonatomic) UIButton *GCButtonWC;//吴淞高程
@end

@implementation SQXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置标题
    NSArray *arr = [[NSArray alloc]initWithObjects:@"水库站",@"河道站",@"其他", nil];
    UISegmentedControl *SQXX_Segmented = [[UISegmentedControl alloc]initWithItems:arr];
    SQXX_Segmented.frame = CGRectMake(0, 0, self.view.bounds.size.width/2, self.navigationController.navigationBar.bounds.size.height/3*2);
    SQXX_Segmented.momentary = NO;
    SQXX_Segmented.tintColor = [UIColor whiteColor];
    SQXX_Segmented.selectedSegmentIndex = 0;//设置默认选中位置
    [self.navigationItem setTitleView:SQXX_Segmented];
    
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
    
    //下方两个Button的添加
    UIView *GCView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16*15-64, self.view.bounds.size.width, self.view.bounds.size.height/16)];
    GCView.backgroundColor = [UIColor colorWithRed:0.06 green:0.15 blue:0.27 alpha:1.0];
    [self.view addSubview:GCView];
    
    self.GCButton85 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/32*5, GCView.bounds.size.height/6, self.view.bounds.size.width/16*3, GCView.bounds.size.height/3*2)];
    self.GCButton85.layer.masksToBounds = YES;
    self.GCButton85.layer.cornerRadius = self.GCButton85.bounds.size.height/10;
    [self.GCButton85 setTitle:@"85高程" forState:UIControlStateNormal];
    self.GCButton85.titleLabel.font = [UIFont systemFontOfSize:self.GCButton85.bounds.size.height/20*9];
    self.GCButton85.backgroundColor = [UIColor blueColor];
    [self.GCButton85 addTarget:self action:@selector(GCTouch85) forControlEvents:UIControlEventTouchDown];
    [GCView addSubview:self.GCButton85];
    
    self.GCButtonWC = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/32*21, GCView.bounds.size.height/6, self.view.bounds.size.width/16*3+5, GCView.bounds.size.height/3*2)];
    self.GCButtonWC.layer.masksToBounds = YES;
    self.GCButtonWC.layer.cornerRadius = self.GCButtonWC.bounds.size.height/10;
    [self.GCButtonWC setTitle:@"吴淞高程" forState:UIControlStateNormal];
    self.GCButtonWC.titleLabel.font = [UIFont systemFontOfSize:self.GCButtonWC.bounds.size.height/20*9];
    [GCView addSubview:self.GCButtonWC];
    [self.GCButtonWC addTarget:self action:@selector(GCTouchWC) forControlEvents:UIControlEventTouchDown];
    [self SQXXTableViewAdd];
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

//列表信息添加
-(void)SQXXTableViewAdd
{
    int i;
    for (i = 0; i<3; i++) {
        self.SQXXLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/16*(i+1)+self.view.bounds.size.width/4*i, 0,self.view.bounds.size.width/4 , self.view.bounds.size.height/16)];
        self.SQXXLabel.textColor = [UIColor blackColor];
        self.SQXXLabel.textAlignment = NSTextAlignmentCenter;
        self.SQXXLabel.font = [UIFont systemFontOfSize:self.SQXXLabel.bounds.size.height/22*7];
        [self.view addSubview:self.SQXXLabel];
        
        if (i == 0) {
            self.SQXXLabel.text = @"站点名称";
        }else if (i == 1)
        {
            self.SQXXLabel.text = @"实时水位(m)";
        }else if (i == 2)
        {
            self.SQXXLabel.text = @"警戒／汛限(m)";
        }
    }
    
    //设置YQXX_TableView,并添加在YQXX_ScrollView上
    self.SQXXTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16, self.view.bounds.size.width, self.view.bounds.size.height/8*7-64) style:UITableViewStylePlain];
    self.SQXXTableView.tableFooterView.frame = CGRectZero;
    self.SQXXTableView.tableHeaderView.frame = CGRectZero;
    self.SQXXTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.SQXXTableView.backgroundColor = [UIColor whiteColor];
    self.SQXXTableView.delegate = self;
    self.SQXXTableView.dataSource = self;
    [self.view addSubview:self.SQXXTableView];
}

//85高程点击事件
-(void)GCTouch85
{
    self.GCButton85.backgroundColor = [UIColor blueColor];
    self.GCButtonWC.backgroundColor = [UIColor clearColor];
}

//吴淞高程点击事件
-(void)GCTouchWC
{
    self.GCButtonWC.backgroundColor = [UIColor blueColor];
    self.GCButton85.backgroundColor = [UIColor clearColor];
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
    NSString *CellIdentifier = @"ImageOnRightCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int j;
    for (j = 0; j<3; j++) {
        UILabel *SQXXlabelCell = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/16*(j+1)+self.view.bounds.size.width/4*j, 0,self.view.bounds.size.width/4 , self.view.bounds.size.height/16-1)];
        SQXXlabelCell.textColor = [UIColor blackColor];
        SQXXlabelCell.textAlignment = NSTextAlignmentCenter;
        SQXXlabelCell.font = [UIFont systemFontOfSize:SQXXlabelCell.bounds.size.height/5*2];
        [cell.contentView addSubview:SQXXlabelCell];
        if (j == 0) {
            SQXXlabelCell.text = @"站点名称";
            SQXXlabelCell.tag = 1002;
        }else if (j == 1)
        {
            SQXXlabelCell.text = @"0";
        }else if (j == 2)
        {
            SQXXlabelCell.text = @"0";
        }
    }
    
    //自定义分隔线
    UIImageView *imageViewSepE = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/16-1, self.SQXXTableView.bounds.size.width, 1)];
    imageViewSepE.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1.0];
    [cell.contentView addSubview:imageViewSepE];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SW_ViewController *swController = [[SW_ViewController alloc]init];
    [self.navigationController pushViewController:swController animated:YES];
    UILabel *areaLabel = (UILabel *)[self.view viewWithTag:1002];
    swController.navigationItem.title = [areaLabel.text stringByAppendingString:@"水位折线图"];
    [self.SQXXTableView deselectRowAtIndexPath:[self.SQXXTableView indexPathForSelectedRow] animated:YES];
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
