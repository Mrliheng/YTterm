//
//  TrigonView.m
//  YTZG
//
//  Created by 李 恒 on 16/8/8.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "TrigonView.h"

@implementation TrigonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.5);
    
    // 2.画三角形
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 15, 0);
    CGContextAddLineToPoint(ctx, 7.5, 15);
    // 关闭路径(连接起点和最后一个点)
    CGContextClosePath(ctx);
    
    
    CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
    
    // 3.绘制图形
    CGContextStrokePath(ctx);
}

@end
