//
//  OneHRViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/8/16.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "OneHRViewController.h"
#import "MBProgressHUD.h"

@interface OneHRViewController ()<UIWebViewDelegate>
{
    
    //HUD（Head-Up Display，意思是抬头显示的意思）
    
    MBProgressHUD *HUD;
    
}
@property (strong,nonatomic) UIWebView *oneWeb;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong,nonatomic) UIView *mbview;
@end

@implementation OneHRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"一小时降雨预报";
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
    
    
    //气象图View添加
    _oneWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height-64))];
    _oneWeb.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [self.view addSubview:_oneWeb];
    _oneWeb.scrollView.bounces = NO;
    _oneWeb.delegate = self;
    
    NSURL* url = [NSURL URLWithString:@"http://www.zjmb.gov.cn/dsjs/yxsjspt.jsp"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    _oneWeb.delegate = self;
    [_oneWeb loadRequest:request];//加载
    
}


//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}



//WebView的代理
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error) {

    }
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
