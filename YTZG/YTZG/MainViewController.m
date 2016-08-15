//
//  MainViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/7/17.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "MainViewController.h"
#import "BTView.h"
#import "DateNowString.h"
#import "weatherData.h"

#import "DQXQController.h"
#import "YQXXViewController.h"
#import "SQXXViewController.h"
#import "WorkViewController.h"
#import "FXJZViewController.h"
#import "QXGTViewController.h"
#import "TXLViewController.h"
#import "FXYAViewController.h"
#import "YJDXViewController.h"
#import "SetViewController.h"
#import "TFLJViewController.h"
#import "GISViewController.h"


#define kWeatherServiceURLStr @"http://webservice.webxml.com.cn/WebServices/WeatherWebService.asmx/getWeatherbyCityName?heCityName="
@interface MainViewController ()
@property (strong,nonatomic) BTView *btView;
//主界面上方标题试图
@property (strong,nonatomic) UIView *TView;
//用户头像
@property (strong,nonatomic) UIImageView *userImageView;
//欢迎标题
@property (strong,nonatomic) UILabel *WCLlabel;
//日期标题
@property (strong,nonatomic) UILabel *Datelabel;
//天气标题；
@property (strong,nonatomic) UILabel *TQlabel;
//温度标题
@property (strong,nonatomic) UILabel *WDlabel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"山洪防治移动平台";
    //返回隐藏
//    self.navigationItem.hidesBackButton = YES; 
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //主界面上方标题试图
    [self DView];
    //九宫格
    [self mainView];
    
    
}
//主界面上方标题试图设置
- (void)DView{
    //主标题视图
    self.TView = [[UIView alloc]init];
    self.TView.backgroundColor = [UIColor blackColor];
    self.TView.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/6);
    [self.view addSubview:self.TView];
    
    //用户头像
    self.userImageView = [[UIImageView alloc]init];
    self.userImageView.frame = CGRectMake(self.TView.frame.size.height/6, self.TView.frame.size.height/4, self.TView.frame.size.height/3*2, self.TView.frame.size.height/3*2);
    self.userImageView.backgroundColor = [UIColor blueColor];
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width/2;
    [self.TView addSubview:self.userImageView];
    //欢迎
    self.WCLlabel = [[UILabel alloc]init];
    self.WCLlabel.frame = CGRectMake(self.TView.frame.size.height, self.TView.frame.size.height/4, self.TView.frame.size.height/6*5, self.TView.frame.size.height/24*5);
    self.WCLlabel.textAlignment = NSTextAlignmentLeft;
    self.WCLlabel.textColor = [UIColor whiteColor];
    self.WCLlabel.font = [UIFont systemFontOfSize:self.WCLlabel.frame.size.height/25*16];
    self.WCLlabel.text = @"欢迎您";
    ;
    [self.TView addSubview:self.WCLlabel];
    //日期
    self.Datelabel = [[UILabel alloc]init];
    self.Datelabel.frame = CGRectMake(self.TView.frame.size.height, self.TView.frame.size.height/24*13, self.TView.frame.size.height/6*5, self.TView.frame.size.height/24*5);
    self.Datelabel.textAlignment = NSTextAlignmentLeft;
    self.Datelabel.textColor = [UIColor whiteColor];
    self.Datelabel.font = [UIFont systemFontOfSize:self.Datelabel.frame.size.height/25*14];
    [self.TView addSubview:self.Datelabel];
    //当前日期
    DateNowString *dateToday = [[DateNowString alloc]init];
    [dateToday SetTitle];
    self.Datelabel.text = dateToday.dateNow;
    
    //天气
    weatherData *NowWeather = [[weatherData alloc]init];
    [NowWeather SetWeather];
    
    self.TQlabel = [[UILabel alloc]init];
    self.TQlabel.frame = CGRectMake(self.TView.frame.size.width-self.TView.frame.size.height, self.TView.frame.size.height/4, self.TView.frame.size.height/6*5, self.TView.frame.size.height/24*5);
    self.TQlabel.textAlignment = NSTextAlignmentRight;
    self.TQlabel.textColor = [UIColor whiteColor];
    self.TQlabel.font = [UIFont systemFontOfSize:self.TQlabel.frame.size.height/25*14];
    self.TQlabel.text = NowWeather.strWeather;
    [self.TView addSubview:self.TQlabel];
    
    
    //温度
    
    self.WDlabel = [[UILabel alloc]init];
    self.WDlabel.frame = CGRectMake(self.TView.frame.size.width-self.TView.frame.size.height, self.TView.frame.size.height/24*13, self.TView.frame.size.height/6*5, self.TView.frame.size.height/24*5);
    self.WDlabel.textAlignment = NSTextAlignmentRight;
    self.WDlabel.textColor = [UIColor whiteColor];
    self.WDlabel.font = [UIFont systemFontOfSize:self.WDlabel.frame.size.height/25*14];
    self.WDlabel.text = [NSString stringWithFormat:@"%@～%@℃", NowWeather.strTempH,NowWeather.strTempL];
    [self.TView addSubview:self.WDlabel];
    
}

//九宫格设置
-(void)mainView{
    //设置间隙
    float gap;
    self.btView = [[BTView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/5, self.view.bounds.size.height/6)];
    gap = self.btView.frame.size.width/5;
    int x;//第x列
    int y;//第y行
    //添加并设置九宫格
    for ( x = 0; x<4; x++) {
        for ( y = 0; y<3; y++){
            
            BTView *mainBtView = [[BTView alloc]initWithFrame:CGRectMake(gap*(x+1)+self.btView.frame.size.width*x,self.btView.frame.size.height*(y+1)+gap*(y+1) , self.btView.frame.size.width, self.btView.frame.size.height)];
            mainBtView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:mainBtView];
            
            //设置控件
            if ( y == 0 && x == 0 ) {
                
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector00)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"1"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"当前汛情";
            }
            else if (y == 0 && x == 1){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector01)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"2"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"雨情信息";
            }
            else if (y == 0 && x == 2){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector02)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"3"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"水情信息";
            }
            else if (y == 0 && x == 3){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector03)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"4"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"工作信息";
            }
            else if (y == 1 && x == 0){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector10)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"5"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"台风路径";
            }
            else if (y == 1 && x == 1){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector11)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"6"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"防汛救灾";
            }
            else if (y == 1 && x == 2){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector12)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"7"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"气象国土";
            }
            else if (y == 1 && x == 3){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector13)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"8"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"GIS应用";
            }
            else if (y == 2 && x == 0){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector20)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"9"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"通讯录";
            }
            else if (y == 2 && x == 1){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector21)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"10"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"防汛预案";
            }
            else if (y == 2 && x == 2){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector22)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"11"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"预警短信";
            }
            else if (y == 2 && x == 3){
                //控件添加点击事件
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainSelector23)];
                [mainBtView addGestureRecognizer:tapGesture];
                
                //设置ImageView
                [mainBtView.BTImageView setImage:[UIImage imageNamed:@"12"]];
                
                //设置Label
                mainBtView.BTLabel.text = @"设置";
            }
        }
    }
}






//跳转界面


- (void)mainSelector00{
    DQXQController *dqxqController = [[DQXQController alloc]init];
    [self.navigationController pushViewController:dqxqController animated:YES];
    
}//跳转当前汛情

- (void)mainSelector01{
    YQXXViewController *yqxxController = [[YQXXViewController alloc]init];
    [self.navigationController pushViewController:yqxxController animated:YES];
}//跳转雨情信息

- (void)mainSelector02{
    SQXXViewController *sqxxController = [[SQXXViewController alloc]init];
    [self.navigationController pushViewController:sqxxController animated:YES];
}//跳转水情信息

- (void)mainSelector03{
    WorkViewController *workController = [[WorkViewController alloc]init];
    [self.navigationController pushViewController:workController animated:YES];    
}//跳转工作信息

- (void)mainSelector10{
    TFLJViewController *tfljController = [[TFLJViewController alloc]init];
    [self.navigationController pushViewController:tfljController animated:YES];
}//跳转台风路径

- (void)mainSelector11{
    FXJZViewController *fxjzController = [[FXJZViewController alloc]init];
    [self.navigationController pushViewController:fxjzController animated:YES];
}//跳转防汛救灾

- (void)mainSelector12{
    QXGTViewController *qxgtController = [[QXGTViewController alloc]init];
    [self.navigationController pushViewController:qxgtController animated:YES];
}//跳转气象国土

- (void)mainSelector13{
    GISViewController *gisViewController = [[GISViewController alloc]init];
    [self.navigationController pushViewController:gisViewController animated:YES];
}//跳转GIS应用

- (void)mainSelector20{
    TXLViewController *txlController = [[TXLViewController alloc]init];
    [self.navigationController pushViewController:txlController animated:YES];
}//跳转通讯录

- (void)mainSelector21{
    FXYAViewController *fxyaController = [[FXYAViewController alloc]init];
    [self.navigationController pushViewController:fxyaController animated:YES];
}//跳转防汛预案

- (void)mainSelector22{
    YJDXViewController *yjdxController = [[YJDXViewController alloc]init];
    [self.navigationController pushViewController:yjdxController animated:YES];
}//跳转预警短信

- (void)mainSelector23{
    SetViewController *setController = [[SetViewController alloc]init];
    [self.navigationController pushViewController:setController animated:YES];
}//跳转设置


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
