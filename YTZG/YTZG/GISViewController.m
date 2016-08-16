//
//  GISViewController.m
//  YTZG
//
//  Created by 李 恒 on 16/8/10.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "GISViewController.h"
#import "ZDSearchViewController.h"
#import <Mapbox/Mapbox.h>

@interface GISViewController ()<MGLMapViewDelegate>

@end
@import Mapbox;
@implementation GISViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置标题
    self.navigationItem.title = @"GIS应用";
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
    
    //地图添加
    [self Mapadd];
}

//返回上层界面
-(void)touchPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

//搜索
-(void)SearchSet
{
    ZDSearchViewController *zd_search = [[ZDSearchViewController alloc]init];
    [self.navigationController pushViewController:zd_search animated:YES];
}

//地图添加
-(void)Mapadd
{
    MGLMapView *mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Set the map’s center coordinate and zoom level.
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(30.16, 120.10) zoomLevel:8 animated:YES];//浙江杭州
    //    mapView.delegate = self;
    
    
    //标注
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(30.16, 120.10);
    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(30.16, 110.10);
    MGLPointAnnotation *myPointAnnotation = [[MGLPointAnnotation alloc]init];
    [myPointAnnotation setCoordinate:location];
    [mapView selectAnnotation:myPointAnnotation animated:YES];//自动显示注释
    myPointAnnotation.title = @"这是杭州";
    myPointAnnotation.subtitle = @"杭州";
    
    
    MGLPointAnnotation *myPointAnnotation1 = [[MGLPointAnnotation alloc]init];
    [myPointAnnotation1 setCoordinate:location1];
    [mapView selectAnnotation:myPointAnnotation animated:YES];//自动显示注释
    myPointAnnotation1.title = @"这是杭州";
    myPointAnnotation1.subtitle = @"杭州";
    
    [mapView.annotations arrayByAddingObject:myPointAnnotation];
    [mapView.annotations arrayByAddingObject:myPointAnnotation1];
    mapView.showsUserLocation = YES;//显示用户当前位置
    mapView.userInteractionEnabled = YES;
    [mapView setUserTrackingMode:MGLUserTrackingModeFollow animated:YES];
    [self.view addSubview:mapView];
}


-(MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id<MGLAnnotation>)annotation
{
    static NSString *AnnotationViewId= @"annotationid";
    MGLAnnotationView *anView = (MGLAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewId];
    if ([annotation isKindOfClass:[MGLPointAnnotation class]]) {
        anView = [[MGLAnnotationView alloc]initWithReuseIdentifier:AnnotationViewId];
        return anView;
    }
    return nil;
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
