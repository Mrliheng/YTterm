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
        
        _xAxisArray = [NSMutableArray arrayWithObjects:@"8时",@"10时",@"12时",@"14时",@"16时",@"18时",@"20时",@"22时",@"24时",@"次日2时",@"次日4时",@"次日6时", nil];
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
        _subviewsArray = [NSMutableArray arrayWithObjects:@"10.10",@"21",@"13.5",@"4.0",@"1.35",@"23",@"43",@"14",@"15",@"28",@"31",@"45", nil];
        NSArray *array = [_subviewsArray sortedArrayUsingComparator:cmptr];
        
        
        //取最大值
        _maxValue = [[array lastObject]doubleValue];
        //取最小值
        _minValue = [[array firstObject]doubleValue];
        
        //取警戒值
        _WarningValue = 20.809;
        
        //间格数值差
        _yValueInterval = (_maxValue-_minValue)/10;
        _yAxisValueMIN = _minValue;
        if (_yValueInterval <= 0.1) {
            _yValueInterval = 0.1;
        }
        if (_yValueInterval >0.1 && _yValueInterval <= 0.2) {
            _yValueInterval = 0.2;
        }
        if (_yValueInterval >0.2 && _yValueInterval <= 0.5) {
            _yValueInterval = 0.5;
        }
        if (_yValueInterval >0.5 && _yValueInterval <= 1.0) {
            _yValueInterval = 1;
        }
        if (_yValueInterval >1.0 && _yValueInterval <= 2.0) {
            _yValueInterval = 2;
        }
        if (_yValueInterval >2.0 && _yValueInterval <= 5.0) {
            _yValueInterval = 5;
        }
        if (_yValueInterval >5.0 && _yValueInterval <= 10.0) {
            _yValueInterval = 10;
        }
        if (_yValueInterval >10.0 && _yValueInterval <= 20.0) {
            _yValueInterval = 20;
        }
        if (_yValueInterval >20.0 &&  _yValueInterval <= 50.0) {
            _yValueInterval = 50;
        }
        
        
        
        
        _xScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(50, self.bounds.size.height/12, (_subviewsArray.count-1)*xInterval+80, self.bounds.size.height/12*11)];
        _xScroll.showsVerticalScrollIndicator = NO;
        _xScroll.showsHorizontalScrollIndicator =NO;
        _xScroll.bounces = NO;
        _xScroll.backgroundColor = [UIColor whiteColor];
        _xScroll.contentSize = CGSizeMake(_xScroll.bounds.size.width+SCREEN_WIDTH-80, _xScroll.bounds.size.height);
        [self addSubview:_xScroll];
        
        
        [self yAxisSet];//y轴设置
        [self xAxisSet];//x轴设置
        [self WarnLineSet];//警戒线设置
        [self ValuePointSet];//圆点值设置
        
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
    
    _yAxis = [[UIView alloc]initWithFrame:CGRectMake(50, self.bounds.size.height/12, 1, self.bounds.size.height/6*5)];
    _yAxis.backgroundColor = [UIColor blackColor];
    [self addSubview:_yAxis];//y轴添加
    
    [self yInterval];//y轴平行线
    
}


-(void)yInterval
{
    //x轴平行线
    for (int j=0; j<11; j++) {
        UIView *yIntervalView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/12*j, 30+xInterval*(_subviewsArray.count-1),1 )];
        yIntervalView.backgroundColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.0];
        [_xScroll addSubview:yIntervalView];
        
        UILabel *yAxisValue = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/12*11-10-self.bounds.size.height/12*j, 50, 20)];
        yAxisValue.textColor = [UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.0];
        yAxisValue.textAlignment = NSTextAlignmentCenter;
        yAxisValue.font = [UIFont systemFontOfSize:10];
        yAxisValue.text = [NSString stringWithFormat:@"%0.2f",(_yValueInterval*j+_yAxisValueMIN)];
        [self addSubview:yAxisValue];
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
    
    
    for (int i= 0; i<_subviewsArray.count; i++) {
        //平行y轴的线
        UIView *xIntervalView = [[UIView alloc]initWithFrame:CGRectMake(30+xInterval*i, 0, 1, self.bounds.size.height/6*5)];
        xIntervalView.backgroundColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.0];
        [_xScroll addSubview:xIntervalView];
        
        //x轴上的值
        UILabel *xAxisValue = [[UILabel alloc]initWithFrame:CGRectMake(10+xInterval*i, self.bounds.size.height/12*10, xInterval, self.bounds.size.height/12)];
        xAxisValue.textColor = [UIColor colorWithRed:0.74 green:0.74 blue:0.74 alpha:1.0];
        xAxisValue.textAlignment = NSTextAlignmentCenter;
        xAxisValue.font = [UIFont systemFontOfSize:10];
        xAxisValue.text = [_xAxisArray objectAtIndex:i];
        [_xScroll addSubview:xAxisValue];
    }
}

//警戒线设置
-(void)WarnLineSet
{
    //警戒线
    _WarningLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height/6*5-((_WarningValue -_yAxisValueMIN)/_yValueInterval*(self.bounds.size.height/12))-1, 30+xInterval*(_subviewsArray.count-1), 2)];
    _WarningLine.backgroundColor = [UIColor redColor];
    [_xScroll addSubview:_WarningLine];
    if ((_WarningValue > (_minValue+_yValueInterval*10))||(_WarningValue < _minValue)) {
        _WarningLine.hidden = YES;
    }else{
        _WarningLine.hidden = NO;
        
        //警戒label
        UILabel *WarnLabel = [[UILabel alloc]initWithFrame:CGRectMake(_WarningLine.frame.size.width/2, _WarningLine.frame.origin.y-20, _WarningLine.frame.size.width, 20)];
        WarnLabel.backgroundColor = [UIColor clearColor];
        WarnLabel.textAlignment = NSTextAlignmentLeft;
        WarnLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
        WarnLabel.text = [NSString stringWithFormat:@"%0.2f(警戒水位)",_WarningValue];
        WarnLabel.textColor = [UIColor blackColor];
        
        //警戒三角
        _WarningTrigon = [[TrigonView alloc]initWithFrame:CGRectMake(_WarningLine.frame.size.width/2-20, _WarningLine.frame.origin.y-15, 15, 15)];
        _WarningTrigon.backgroundColor = [UIColor clearColor];
        if ((_WarningLine.frame.origin.y-20)< 0) {
            WarnLabel.frame = CGRectMake(_WarningLine.frame.size.width/2, _WarningLine.frame.origin.y-1, _WarningLine.frame.size.width, 20);
            _WarningTrigon.frame =CGRectMake(_WarningLine.frame.size.width/2-20, _WarningLine.frame.origin.y+2, 15, 15);
        };
        [_xScroll addSubview:WarnLabel];
        [_xScroll addSubview:_WarningTrigon];
        
        
    }
}


-(void)ValuePointSet
{
    for (int x=0; x<_subviewsArray.count; x++) {
        //圆点值
        _ValuePointView = [[UIView alloc]initWithFrame:CGRectMake(30+xInterval*x-5, self.bounds.size.height/6*5-(([[_subviewsArray objectAtIndex:x]doubleValue]-_yAxisValueMIN)/_yValueInterval*(self.bounds.size.height/12))-5, 10, 10)];
        _ValuePointView.layer.masksToBounds = YES;
        _ValuePointView.layer.cornerRadius = 5;
        _ValuePointView.backgroundColor = [UIColor redColor];
        [_xScroll addSubview:_ValuePointView];
        
        
        self.visiblePopup = [[ADPopupView alloc] init];
        UITapGestureRecognizer *PointTouch=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PointTouchSet:)];
        [_ValuePointView addGestureRecognizer:PointTouch];
        _ValuePointView.tag = x;
    }
}

- (void)drawRect:(CGRect)rect {
    
    UIGraphicsBeginImageContext(_xScroll.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置线条样式
    
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    
    CGContextSetLineWidth(context, 2.0);
    //设置颜色
    
    CGContextSetRGBStrokeColor(context, 0.16, 0.32, 0.88, 1.0);
    
    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
    for (int y; y<(_subviewsArray.count-1); y++) {
        //开始一个起始路径
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 30+xInterval*y,self.bounds.size.height/6*5-(([[_subviewsArray objectAtIndex:y]doubleValue]-_yAxisValueMIN)/_yValueInterval*(self.bounds.size.height/12)));
        //设置下一个坐标点
        CGContextAddLineToPoint(context, 30+xInterval*(y+1),self.bounds.size.height/6*5-(([[_subviewsArray objectAtIndex:(y+1)]doubleValue]-_yAxisValueMIN)/_yValueInterval*(self.bounds.size.height/12)));
        //连接上面定义的坐标点
        CGContextStrokePath(context);
    }
    
    //结束绘画
    UIImage *destImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //创建UIImageView并显示在界面上
    UIImageView *imgView = [[UIImageView alloc] initWithImage:destImg];
    [_xScroll addSubview:imgView];
    
}
//弹出弹框
- (void)PointTouchSet:(UITapGestureRecognizer *)pointView
{
    
    int p = (int)pointView.view.tag;
    CGPoint point = CGPointMake(30+xInterval*p, self.bounds.size.height/6*5-(([[_subviewsArray objectAtIndex:p]doubleValue]-_yAxisValueMIN)/_yValueInterval*(self.bounds.size.height/12))-5);
    _yudianValue = [NSString stringWithFormat:@"%0.2f",[[_subviewsArray objectAtIndex:p]doubleValue]];
    [self.visiblePopup AtPoint:point delegate:self withMessage:_yudianValue];
    self.visiblePopup.popupColor = [UIColor darkGrayColor];
    [self.visiblePopup showInView:_xScroll animated:YES];
    
    //点击空白区域
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    tap.cancelsTouchesInView = NO; // Allow touches through to a UITableView or other touchable view, as suggested by Dimajp.
    [self addGestureRecognizer:tap];
    
}


- (void)tapped:(UITapGestureRecognizer *)tap
{
    //移除弹框
    [self.visiblePopup removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
