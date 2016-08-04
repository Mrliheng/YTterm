//
//  zxLIneView.h
//  YTZG
//
//  Created by 李 恒 on 16/8/2.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADPopupView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define xInterval 40
@interface zxLIneView : UIView <ADPopupViewDelegate>
@property (strong,nonatomic) UILabel *yBLabel;//y轴单位
@property (strong,nonatomic) UIView *yAxis;//y轴
@property (strong,nonatomic) UIScrollView *xScroll;
@property (strong,nonatomic) NSMutableArray *subviewsArray;//数值

@property (strong,nonatomic) NSMutableArray *xAxisArray;//x轴对应的值
@property (strong,nonatomic) UILabel *xBLabel;//x轴单位

@property (strong,nonatomic) UIView *ValuePointView;//圆点
@property (strong,nonatomic) NSString *yudianValue;

@property (nonatomic) double yAxisValueMIN;//y轴原点
@property (nonatomic) double yValueInterval;//y轴每个间隔的数值差
@property (nonatomic) double maxValue;//最大值
@property (nonatomic) double minValue;//最小值

@property (nonatomic, strong) ADPopupView *visiblePopup;

@end
