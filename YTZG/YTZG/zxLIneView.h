//
//  zxLIneView.h
//  YTZG
//
//  Created by 李 恒 on 16/8/2.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define xInterval 40
@interface zxLIneView : UIView
@property (strong,nonatomic) UILabel *yBLabel;//y轴单位
@property (strong,nonatomic) UIView *yAxis;//y轴
@property (strong,nonatomic) UIScrollView *xScroll;
@property (strong,nonatomic) NSMutableArray *subviewsArray;
@property (strong,nonatomic) UILabel *xBLabel;//x轴单位

@property (nonatomic) double maxValue;//最大值
@property (nonatomic) double minValue;//最小值
@end
