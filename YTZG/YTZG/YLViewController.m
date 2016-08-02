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
    
    self.view.backgroundColor = [UIColor whiteColor];//背景颜色
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
    
    
    //设置切换按钮
    UIButton *SwitchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    SwitchButton.frame = CGRectMake(0, 0, 20, 20);
    [SwitchButton setImage:[UIImage imageNamed:@"drop4"] forState:UIControlStateNormal];
    [SwitchButton addTarget:self action:@selector(SwitchSet) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *SwitchNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:SwitchButton];
    self.navigationItem.rightBarButtonItem = SwitchNavigationItem;
    
    [self ButtonAdd];//label添加
    [self RzzViewAdd];// 日雨量柱状图添加
    [self SzzViewAdd];// 时雨量柱状图添加
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
    float y_value = SCREEN_HEIGHT/40;
    float h_value = SCREEN_HEIGHT/14;
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

//日雨量柱状图
-(void)RzzViewAdd
{
    ZFBarChart * RbarChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/14, SCREEN_WIDTH, SCREEN_HEIGHT/7*6-20)];
    RbarChart.xLineValueArray = [NSMutableArray arrayWithObjects:@"30", @"197", @"200", @"193", @"236", @"217",@"30", @"197", @"200", @"193", @"236", @"217", nil];
    RbarChart.xLineTitleArray = [NSMutableArray arrayWithObjects:@"1日8时", @"2日8时", @"3日8时", @"4日8时", @"5日8时", @"6日8时",@"7日8时", @"8日8时", @"9日8时", @"10日8时", @"11日8时", @"12日8时", nil];
    RbarChart.yLineMaxValue = 250;
    RbarChart.yLineSectionCount = 10;
    [self.view addSubview:RbarChart];
    [RbarChart strokePath];
    
    //y轴单位
    UILabel *Ry_label =[[UILabel alloc]initWithFrame:CGRectMake(5, SCREEN_HEIGHT/30, 70, 20)];
    Ry_label.lineBreakMode = NSLineBreakByWordWrapping;
    Ry_label.numberOfLines = 0;
    Ry_label.text = @"降雨量(mm)";
    Ry_label.font = [UIFont systemFontOfSize:12];
    Ry_label.textColor = [UIColor blackColor];
    Ry_label.textAlignment = NSTextAlignmentCenter;
    [RbarChart addSubview:Ry_label];
    
    //x轴单位
    UILabel *Rx_label =[[UILabel alloc]initWithFrame:CGRectMake(RbarChart.contentSize.width-43, SCREEN_HEIGHT/64*43, 35, 20)];
    Rx_label.lineBreakMode = NSLineBreakByWordWrapping;
    Rx_label.numberOfLines = 0;
    Rx_label.text = @"7月";
    Rx_label.font = [UIFont systemFontOfSize:12];
    Rx_label.textColor = [UIColor blackColor];
    Rx_label.textAlignment = NSTextAlignmentLeft;
    [RbarChart addSubview:Rx_label];
}

//时雨量柱状图
-(void)SzzViewAdd
{
    ZFBarChart * SbarChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/14*15, SCREEN_WIDTH, SCREEN_HEIGHT/7*6)];
    SbarChart.backgroundColor = [UIColor whiteColor];
    SbarChart.xLineValueArray = [NSMutableArray arrayWithObjects:@"30", @"197", @"200", @"193", @"236", @"217",@"30", @"197", @"200", @"193", @"236", @"217", nil];
    SbarChart.xLineTitleArray = [NSMutableArray arrayWithObjects:@"8时", @"10时", @"12时", @"14时", @"16时", @"18时",@"20时", @"22时", @"次日0时", @"次日2时", @"次日4时", @"次日6时", nil];
    SbarChart.yLineMaxValue = 250;
    SbarChart.yLineSectionCount = 10;
    [self.view addSubview:SbarChart];
    [SbarChart strokePath];
    
    //y轴单位
    UILabel *Ry_label =[[UILabel alloc]initWithFrame:CGRectMake(5, SCREEN_HEIGHT/30, 70, 20)];
    Ry_label.lineBreakMode = NSLineBreakByWordWrapping;
    Ry_label.numberOfLines = 0;
    Ry_label.text = @"降雨量(mm)";
    Ry_label.font = [UIFont systemFontOfSize:12];
    Ry_label.textColor = [UIColor blackColor];
    Ry_label.textAlignment = NSTextAlignmentCenter;
    [SbarChart addSubview:Ry_label];
    
    //x轴单位
    UILabel *Rx_label =[[UILabel alloc]initWithFrame:CGRectMake(SbarChart.contentSize.width-43, SCREEN_HEIGHT/64*43, 35, 20)];
    Rx_label.lineBreakMode = NSLineBreakByWordWrapping;
    Rx_label.numberOfLines = 0;
    Rx_label.text = @"7月";
    Rx_label.font = [UIFont systemFontOfSize:12];
    Rx_label.textColor = [UIColor blackColor];
    Rx_label.textAlignment = NSTextAlignmentLeft;
    [SbarChart addSubview:Rx_label];
}

//日雨量与时雨量的切换
-(void)SwitchSet
{
    if (self.view.frame.origin.y == 0 || self.view.frame.origin.y == 64) {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
        self.view.frame = CGRectMake(0, -SCREEN_HEIGHT+64, self.view.bounds.size.width, SCREEN_HEIGHT*2); //64-216
        [UIView commitAnimations];
    }else{
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, SCREEN_HEIGHT*2); //64-216
        [UIView commitAnimations];
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
