//
//  zxLIneView.m
//  YTZG
//
//  Created by 李 恒 on 16/8/2.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "zxLIneView.h"

@implementation zxLIneView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        //数组排序(从小到大)
        NSComparator cmptr = ^(id obj1, id obj2){
            
            if ([obj1 doubleValue] > [obj2 doubleValue]) {
                
                return (NSComparisonResult)NSOrderedDescending;
            }
            if ([obj1 doubleValue] < [obj2 doubleValue]) {
                
                return (NSComparisonResult)NSOrderedAscending;
            }
            
            return (NSComparisonResult)NSOrderedSame;
            
        };
        _subviewsArray = [NSMutableArray arrayWithObjects:@"1.10",@"21",@"13.5",@"4.0",@"100.35",@"23",@"43",@"14",@"15",@"28",@"31",@"45", nil];
        NSArray *array = [_subviewsArray sortedArrayUsingComparator:cmptr];
        //取最大值
        _maxValue = [[array lastObject]doubleValue];
        //取最小值
        _minValue = [[array firstObject]doubleValue];
        
        _xScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(31, self.bounds.size.height/12, (_subviewsArray.count-1)*xInterval+80, self.bounds.size.height/12*11)];
        _xScroll.showsVerticalScrollIndicator = NO;
        _xScroll.showsHorizontalScrollIndicator =NO;
        _xScroll.bounces = NO;
        _xScroll.backgroundColor = [UIColor whiteColor];
        _xScroll.contentSize = CGSizeMake(_xScroll.bounds.size.width+SCREEN_WIDTH-80, _xScroll.bounds.size.height);
        [self addSubview:_xScroll];
        [self yAxisSet];//y轴设置
        [self yInterval];//y轴平行线
        [self xAxisSet];//x轴设置
    }
    return self;
    
}

//y轴设置
-(void)yAxisSet
{
    _yBLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, self.bounds.size.height/12)];
    _yBLabel.textColor = [UIColor blackColor];
    _yBLabel.textAlignment = NSTextAlignmentCenter;
    _yBLabel.font = [UIFont systemFontOfSize:14];
    _yBLabel.text = @"水位(m)";
    [self addSubview:_yBLabel];//y轴单位添加
    
    _yAxis = [[UIView alloc]initWithFrame:CGRectMake(30, self.bounds.size.height/12, 1, self.bounds.size.height/6*5)];
    _yAxis.backgroundColor = [UIColor blackColor];
    [self addSubview:_yAxis];//y轴添加
}

//y轴平行线
-(void)yInterval
{
    for (int i= 0; i<_subviewsArray.count; i++) {
        UIView *xIntervalView = [[UIView alloc]initWithFrame:CGRectMake(30+xInterval*i, 0, 1, self.bounds.size.height/6*5)];
        xIntervalView.backgroundColor = [UIColor brownColor];
        [_xScroll addSubview:xIntervalView];
    }
}

//x轴设置
-(void)xAxisSet
{
    _xBLabel = [[UILabel alloc]initWithFrame:CGRectMake(30+xInterval*(_subviewsArray.count-1), self.bounds.size.height/24*19, 50, self.bounds.size.height/12)];
    _xBLabel.textColor = [UIColor blackColor];
    _xBLabel.textAlignment = NSTextAlignmentCenter;
    _xBLabel.font = [UIFont systemFontOfSize:14];
    _xBLabel.text = @"时间";
    [_xScroll addSubview:_xBLabel];//x轴单位添加
    
    for (int j=0; j<11; j++) {
        UIView *yIntervalView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/12*j, 30+xInterval*(_subviewsArray.count-1),1 )];
        yIntervalView.backgroundColor = [UIColor brownColor];
        [_xScroll addSubview:yIntervalView];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
