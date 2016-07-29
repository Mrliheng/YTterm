//
//  YLViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/21.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "YLViewController.h"
#import "DateNowString.h"
#import "zzGraphViewController.h"
@interface YLViewController ()
@property (nonatomic, retain) zzGraphViewController *iPhoneGraph;
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
    _iPhoneGraph = [[zzGraphViewController alloc]init];
    _iPhoneGraph.secondArray = @[[NSNumber numberWithDouble:-0.30],[NSNumber numberWithDouble:-0.23],[NSNumber numberWithDouble:0.12],[NSNumber numberWithDouble:-0.34],[NSNumber numberWithDouble:0.21],[NSNumber numberWithDouble:0.32],[NSNumber numberWithDouble:-0.43],[NSNumber numberWithDouble:-0.12],[NSNumber numberWithDouble:0.34],[NSNumber numberWithDouble:0.43],[NSNumber numberWithDouble:0.40],[NSNumber numberWithDouble:0.50]];
    
    [_iPhoneGraph setFrame:CGRectMake(20,self.view.bounds.size.height/7, self.view.bounds.size.width, self.view.bounds.size.height/7*6)];
    
    [_iPhoneGraph setLinesGraph:NO];
    [self.view addSubview:_iPhoneGraph];
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
