//
//  SW_ViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/21.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "SW_ViewController.h"
#import "DateNowString.h"

#import "zxLIneView.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
@interface SW_ViewController ()

@end

@implementation SW_ViewController

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
    
    //设置切换按钮
    UIButton *SwitchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    SwitchButton.frame = CGRectMake(0, 0, 20, 20);
    [SwitchButton setImage:[UIImage imageNamed:@"drop4"] forState:UIControlStateNormal];
    [SwitchButton addTarget:self action:@selector(SwitchSet) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *SwitchNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:SwitchButton];
    self.navigationItem.rightBarButtonItem = SwitchNavigationItem;
    
    self.view.backgroundColor = [UIColor whiteColor];//背景颜色
    [self ButtonAdd];//label添加
    [self ScrollViewAdd];//ScrollView添加
    [self zLineViewAdd];//自定义折线图添加
    
}
//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
//日期、上一天、今日、下一天
-(void)ButtonAdd
{
    float jianju = SCREEN_WIDTH/16;
    float y_value = SCREEN_HEIGHT/40;
    float h_value = SCREEN_HEIGHT/14;
    //日期label
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(jianju, y_value, SCREEN_WIDTH/32*7, h_value)];
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
            TouchBt.frame = CGRectMake(jianju*2+SCREEN_WIDTH/32*7, y_value, SCREEN_WIDTH/64*11, h_value);
            [TouchBt setTitle:@"上一天" forState:UIControlStateNormal];
        }//上一天
        else if (i==1) {
            TouchBt.frame = CGRectMake(jianju*3+SCREEN_WIDTH/64*25, y_value, SCREEN_WIDTH/8, h_value);
            [TouchBt setTitle:@"今日" forState:UIControlStateNormal];
        }//今日
        else if (i==2) {
            TouchBt.frame = CGRectMake(jianju*4+SCREEN_WIDTH/64*33, y_value, SCREEN_WIDTH/64*11, h_value);
            [TouchBt setTitle:@"下一天" forState:UIControlStateNormal];
        }//下一天
        
    }
}
//ScrollView添加
-(void)ScrollViewAdd
{
    UIScrollView *SWScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/14, SCREEN_WIDTH*2+20, SCREEN_HEIGHT/7*6)];
    SWScrollView.showsHorizontalScrollIndicator = NO;
    SWScrollView.showsVerticalScrollIndicator = NO;//隐藏滑动条
    SWScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3+40, 0);//禁止竖直方向滑动
    [self.view addSubview:SWScrollView];
    
    //折线图添加
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH*2,SCREEN_HEIGHT/7*5)];
    
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                       kYAxisLabelSideMarginsKey : @20,
                                       kPlotBackgroundLineColorKye : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    _lineGraph.yAxisRange = @(22.30);//y周最大值
    _lineGraph.yAxisSuffix = @"";//y轴单位
    _lineGraph.xAxisValues = @[
                               @{ @1 : @"00时" },
                               @{ @2 : @"02时" },
                               @{ @3 : @"04时" },
                               @{ @4 : @"06时" },
                               @{ @5 : @"08时" },
                               @{ @6 : @"10时" },
                               @{ @7 : @"12时" },
                               @{ @8 : @"14时" },
                               @{ @9 : @"16时" },
                               @{ @10 : @"18时" },
                               @{ @11 : @"20时" },
                               @{ @12 : @"22时" }
                               ];//x轴
    SHPlot *_plot1 = [[SHPlot alloc] init];
    _plot1.plottingValues = @[
                              @{ @1 : @21.8 },
                              @{ @2 : @21.33 },
                              @{ @3 : @21.4 },
                              @{ @4 : @22 },
                              @{ @5 : @21.3 },
                              @{ @6 : @21.8 },
                              @{ @7 : @22.1 },
                              @{ @8 : @22.1 },
                              @{ @9 : @22.3 },
                              @{ @10 : @21.22 },
                              @{ @11 : @22.1 },
                              @{ @12 : @22.3 }
                              ];//各时间的值
    NSDictionary *_plotThemeAttributes = @{
                                           kPlotFillColorKey : [UIColor colorWithRed:0.47 green:0.75 blue:0.78 alpha:0.5],
                                           kPlotStrokeWidthKey : @2,
                                           kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                           kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                           };
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    [_lineGraph addPlot:_plot1];
    [_lineGraph setupTheView];
    
    [SWScrollView addSubview:_lineGraph];
}

//自定义折线图添加
-(void)zLineViewAdd
{
    zxLIneView *zxView = [[zxLIneView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/14*15, SCREEN_WIDTH, SCREEN_HEIGHT/7*6-64)];
    [self.view addSubview:zxView];
}

-(void)SwitchSet
{
    if (self.view.frame.origin.y == 0 || self.view.frame.origin.y == 64) {
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
        self.view.frame = CGRectMake(0, -SCREEN_HEIGHT+64, SCREEN_WIDTH, SCREEN_HEIGHT*2); //64-216
        [UIView commitAnimations];
    }else{
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@ "ResizeForKeyboard"  context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
        self.view.frame = CGRectMake(0, 64, SCREEN_HEIGHT, SCREEN_HEIGHT*2); //64-216
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
