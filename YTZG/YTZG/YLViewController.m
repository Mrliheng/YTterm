//
//  YLViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/21.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "YLViewController.h"
#import "DateNowString.h"
#import "ZFChart.h"
@interface YLViewController ()

@end

@implementation YLViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];//背景颜色
    [self ButtonAdd];//label添加
    [self zzViewAdd];// 柱状图添加
}


//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//日期、上一天、今日、下一天
-(void)ButtonAdd
{
    float jianju = self.view.bounds.size.width/16;
    float y_value = self.view.bounds.size.height/40;
    float h_value = self.view.bounds.size.height/14;
    //日期label
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(jianju, y_value, self.view.bounds.size.width/32*7, h_value)];
    dateLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    dateLabel.textColor = [UIColor blackColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont systemFontOfSize:h_value/3];
    //当前日期
    DateNowString *dateToday = [[DateNowString alloc]init];
    [dateToday SetTitle];
    dateLabel.text = dateToday.MDdateNow;
    
    dateLabel.layer.masksToBounds = YES;
    dateLabel.layer.cornerRadius = h_value/5;
    [self.view addSubview:dateLabel];
    
    //button添加
    int i;
    for(i =0 ;i<3;i++){
        UIButton * TouchBt = [[UIButton alloc]init];
        TouchBt.titleLabel.font = [UIFont systemFontOfSize:h_value/3];
        TouchBt.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
        [TouchBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        TouchBt.layer.masksToBounds = YES;
        TouchBt.layer.cornerRadius = h_value/5;
        [self.view addSubview:TouchBt];
        if (i==0) {
            TouchBt.frame = CGRectMake(jianju*2+self.view.bounds.size.width/32*7, y_value, self.view.bounds.size.width/64*11, h_value);
            [TouchBt setTitle:@"上一天" forState:UIControlStateNormal];
        }//上一天
        else if (i==1) {
            TouchBt.frame = CGRectMake(jianju*3+self.view.bounds.size.width/64*25, y_value, self.view.bounds.size.width/8, h_value);
            [TouchBt setTitle:@"今日" forState:UIControlStateNormal];
        }//今日
        else if (i==2) {
            TouchBt.frame = CGRectMake(jianju*4+self.view.bounds.size.width/64*33, y_value, self.view.bounds.size.width/64*11, h_value);
            [TouchBt setTitle:@"下一天" forState:UIControlStateNormal];
        }//下一天
    }
    
}


-(void)zzViewAdd
{
    ZFBarChart * barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/14, SCREEN_WIDTH, self.view.bounds.size.height/7*6)];
    barChart.xLineValueArray = [NSMutableArray arrayWithObjects:@"30", @"197", @"200", @"193", @"236", @"217",@"30", @"197", @"200", @"193", @"236", @"217", nil];
    barChart.xLineTitleArray = [NSMutableArray arrayWithObjects:@"1日8时", @"2日8时", @"3日8时", @"4日8时", @"5日8时", @"6日8时",@"7日8时", @"8日8时", @"9日8时", @"10日8时", @"11日8时", @"12日8时", nil];
    barChart.yLineMaxValue = 250;
    barChart.yLineSectionCount = 10;
    [self.view addSubview:barChart];
    [barChart strokePath];
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
