//
//  WFViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/8/16.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "WFViewController.h"
#import "MBProgressHUD.h"
@interface WFViewController ()<UIWebViewDelegate>
{
    
    //HUD（Head-Up Display，意思是抬头显示的意思）
    
    MBProgressHUD *HUD;
    
}
@property (strong,nonatomic) UIWebView *wfWeb;
@end

@implementation WFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"天气预报";
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
    
    
    //天气预报Web添加
    _wfWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height-64))];
    _wfWeb.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [self.view addSubview:_wfWeb];
    _wfWeb.scrollView.bounces = NO;
    _wfWeb.delegate = self;
    
    NSURL* url = [NSURL URLWithString:@"http://alibaba.weather.com.cn/"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_wfWeb loadRequest:request];//加载
}


//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}


//WebView的代理
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.detailsLabelText = @"加载中...";
    HUD.removeFromSuperViewOnHide = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    HUD.detailsLabelText = @"加载完成";
    // 设置图片
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"success.png"]]];
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD removeFromSuperViewOnHide];
    [HUD hide:YES afterDelay:1.0];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error) {
        HUD.detailsLabelText = @"加载错误";
        // 设置图片
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"error.png"]]];
        // 再设置模式
        HUD.mode = MBProgressHUDModeCustomView;
        // 隐藏时候从父控件中移除
        HUD.removeFromSuperViewOnHide = YES;
        // 1秒之后再消失
        [HUD hide:YES afterDelay:1.0];
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
