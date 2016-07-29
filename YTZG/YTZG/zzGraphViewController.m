//
//  iPhoneGraphViewController.m
//  Graph for iPhone
//
//  Created by Serghei Mazur on 11/26/13.
//  Copyright (c) 2013 Serghei Mazur. All rights reserved.
//

#import "zzGraphViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation zzGraphViewController

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    float maxY = 0.5;
    bool  minusValue = NO;
    bool nothingShow = NO;
    
    for (NSNumber *number in _fistArray) {
        if (maxY < fabs([number doubleValue])) {
            maxY = fabs([number doubleValue]);
        }
        if ([number doubleValue] < 0) {
            minusValue = YES;
            
        }
    }
    for (NSNumber *number in _secondArray) {
        if (maxY < fabs([number floatValue])) {
            maxY = fabs([number floatValue]);
        }
        if ([number floatValue] < 0) {
            minusValue = YES;
        }
    }
    
    if (maxY < 0.5) {
        maxY = 0.5;
        nothingShow = YES;
    }
    
    //coefficient
    double coefficient = 75*3/maxY;
    
    UIColor *currentColor = [UIColor blackColor];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context); // <---- this
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
    
    // line X
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context,    5*1.5, 75*3);
    CGContextAddLineToPoint(context, 260*1.5, 75*3);
    CGContextAddLineToPoint(context, 252*1.5, 71*3);
    CGContextAddLineToPoint(context, 260*1.5, 75*3);
    CGContextAddLineToPoint(context, 252*1.5, 79*3);
    CGContextStrokePath(context);
    
    //Create 5 strike line for see difference
    //And for +  and -
    float halfGraph = 75*3;
    float yNumber = 0;
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<5; j++) {
            halfGraph -= 15*3;
            yNumber +=maxY/5;
            CGFloat dashes[] = { 1, 1 };
            CGContextSetLineDash( context, 0.0, dashes, 2 );
            CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
            CGContextMoveToPoint(context, 0,halfGraph);
            CGContextAddLineToPoint(context, 260*1.5, halfGraph);
            CGContextStrokePath(context);
            
            UILabel *gradationLabel = [[UILabel alloc]initWithFrame:CGRectMake(-45, halfGraph, 50, 15)];
            gradationLabel.backgroundColor = [UIColor clearColor];
            gradationLabel.textAlignment = NSTextAlignmentRight;
            [gradationLabel setFont:[UIFont systemFontOfSize:10]];
            [gradationLabel setAdjustsFontSizeToFitWidth:YES];
            
            if (!nothingShow) {
                if (!minusValue && i > 0) {
                    
                } else{
                    gradationLabel.text = [NSString stringWithFormat:yNumber == (float)yNumber?@"%.2f":@"%.2f",yNumber];
                }
            }
            gradationLabel.textColor = [UIColor grayColor];
            [self addSubview:gradationLabel];
        }
        halfGraph = 165*3;
        yNumber = -maxY-maxY/5;
        
        //If Graph don't have < 0 value  No need wite numbers with minus (i = 2 exit loop)
    }
    
    //Create 12 strike line for month
    
    halfGraph = 4;
    if (_months == nil) {
        _months = [[NSArray alloc]initWithObjects:@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", nil];
    }
    
    //y虚线
    for (int i = 0; i<12; i++) {
        halfGraph += 20*1.5;
        CGFloat dashes[] = { 1, 1 };
        CGContextSetLineDash( context, 0.0, dashes, 2 );
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextMoveToPoint(context, halfGraph,0);
        CGContextAddLineToPoint(context, halfGraph, 150*3);
        CGContextStrokePath(context);
        
        UILabel *gradationLabel = [[UILabel alloc]initWithFrame:CGRectMake(halfGraph-40, 150*3, 50, 20)];
        gradationLabel.backgroundColor = [UIColor clearColor];
        gradationLabel.textAlignment = NSTextAlignmentRight;
        [gradationLabel setFont:[UIFont systemFontOfSize:10]];
        [gradationLabel setAdjustsFontSizeToFitWidth:YES];
        gradationLabel.text = [NSString stringWithFormat:@"%@",[_months objectAtIndex:i]];
        gradationLabel.textColor = [UIColor grayColor];
        [self addSubview:gradationLabel];
    }
    
    CGContextSetLineDash(context, 0, NULL, 0);
    UILabel *xLabel = [[UILabel alloc]initWithFrame:CGRectMake(-10, -25, 100, 30)];
    xLabel.backgroundColor = [UIColor clearColor];
    [xLabel setFont:[UIFont systemFontOfSize:11]];
    xLabel.textColor = [UIColor darkGrayColor];
    xLabel.text = @"Money";
    [self addSubview:xLabel];
    
    UILabel *zeroLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 72*3, 30, 20)];
    zeroLabel.backgroundColor = [UIColor clearColor];
    zeroLabel.textColor = [UIColor grayColor];
    [zeroLabel setFont:[UIFont systemFontOfSize:11]];
    zeroLabel.text = @"0";
    [self addSubview:zeroLabel];
    
    // line Y
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, 10*1.5,150*3);
    CGContextAddLineToPoint(context, 10*1.5, 5*3);
    CGContextAddLineToPoint(context, 6*1.5, 10*3);
    CGContextAddLineToPoint(context, 10*1.5, 5*3);
    CGContextAddLineToPoint(context, 14*1.5, 10*3);
    CGContextStrokePath(context);
    
    UILabel *yLabel = [[UILabel alloc]initWithFrame:CGRectMake(260*1.5, 70*3, 100, 30)];
    yLabel.backgroundColor = [UIColor clearColor];
    [yLabel setFont:[UIFont systemFontOfSize:11]];
    yLabel.textColor = [UIColor darkGrayColor];
    yLabel.text = @"Month";
    [self addSubview:yLabel];
    
    CGContextSetLineWidth(context, 1.0);
    
    //FirstArray
    
    if (_linesGraph) {
        double demoData[31] = {[[_fistArray objectAtIndex:0] doubleValue],[[_fistArray objectAtIndex:1] doubleValue],[[_fistArray objectAtIndex:2] doubleValue],[[_fistArray objectAtIndex:3] doubleValue],[[_fistArray objectAtIndex:4] doubleValue],[[_fistArray objectAtIndex:5] doubleValue],[[_fistArray objectAtIndex:6] doubleValue],[[_fistArray objectAtIndex:7] doubleValue],[[_fistArray objectAtIndex:8] doubleValue],[[_fistArray objectAtIndex:9] doubleValue],[[_fistArray objectAtIndex:10] doubleValue],[[_fistArray objectAtIndex:11] doubleValue]};
        yLabel.text = @"Month";
        double distanceNextYline = 20;
        double bizieLineAligm = 10;
        
        double nextX = 24;
        double downToXline = 75*3;
        double corectPointer1 = downToXline - demoData[0]*coefficient;
        //        NSLog(@"FirstPOint:  %f , %f",nextX,downToXline - demoData[0]*coefficient);
        
        CGMutablePathRef spadePath = CGPathCreateMutable();
        CGPathMoveToPoint(spadePath, NULL, nextX, downToXline - demoData[0]*coefficient);
        
        
        for (int i = 1; i < [_fistArray count]; i++) {
            CGPathAddCurveToPoint(spadePath, NULL, nextX+bizieLineAligm, corectPointer1, nextX+distanceNextYline-bizieLineAligm, downToXline - demoData[i]*coefficient, nextX+distanceNextYline, downToXline - demoData[i]*coefficient);
            //            NSLog(@"POint %d: %f , %f %f %f %f %f",i,nextX+bizieLineAligm, corectPointer1, nextX+distanceNextYline-bizieLineAligm, downToXline - demoData[i], nextX+distanceNextYline, downToXline - demoData[i]);
            nextX +=distanceNextYline;
            corectPointer1 = downToXline - demoData[i]*coefficient;
        }
        [[UIColor colorWithRed:54.0/255.0f green:133.0f/255.0f blue:37.0f/255.0f alpha:1.0f] set];
        CGContextSetLineWidth(context, 2);
        CGContextAddPath(context, spadePath);
        
        CGContextStrokePath(context);
        
        
    } else {
        
        
        if ([_fistArray count] == 12) {
            double demoData[12] = {[[_fistArray objectAtIndex:0] doubleValue],[[_fistArray objectAtIndex:1] doubleValue],[[_fistArray objectAtIndex:2] doubleValue],[[_fistArray objectAtIndex:3] doubleValue],[[_fistArray objectAtIndex:4] doubleValue],[[_fistArray objectAtIndex:5] doubleValue],[[_fistArray objectAtIndex:6] doubleValue],[[_fistArray objectAtIndex:7] doubleValue],[[_fistArray objectAtIndex:8] doubleValue],[[_fistArray objectAtIndex:9] doubleValue],[[_fistArray objectAtIndex:10] doubleValue],[[_fistArray objectAtIndex:11] doubleValue]};
            
            int coor = 22*1.5;
            for (int i = 0; i<12; i++) {
                
                    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:96.0f/255.0f green:172.0f/255.0f blue:96.0f/255.0f alpha:1].CGColor);
                    CGContextSetRGBFillColor(context, 96.0f/255.0f, 172.0f/255.0f, 96.0f/255.0f, 1.0);
                
                CGContextSetShadow(context,CGSizeMake(2, 2) , 2);
                CGMutablePathRef pathRef = CGPathCreateMutable();
                CGPathMoveToPoint(pathRef, NULL, coor, 75*3);
                CGPathAddLineToPoint(pathRef, NULL, coor, -demoData[i]*coefficient+75*3);
                CGPathAddLineToPoint(pathRef, NULL, (coor+8), -demoData[i]*coefficient+75*3);
                CGPathAddLineToPoint(pathRef, NULL, (coor+8), 75*3);
                CGPathCloseSubpath(pathRef);
                CGContextAddPath(context, pathRef);
                CGContextFillPath(context);
                CGContextAddPath(context, pathRef);
                CGContextStrokePath(context);
                
                
                CGPathRelease(pathRef);
                int negCor;
                if (demoData[i]>0) {
                    negCor = 15;
                } else {
                    negCor = 3;
                }
                UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake((coor+1.5), -demoData[i]*coefficient+75*3-negCor, 50, 20)];
                oneLabel.backgroundColor = [UIColor clearColor];
                
                    oneLabel.textColor = [UIColor colorWithRed:96.0f/255.0f green:172.0f/255.0f blue:96.0f/255.0f alpha:1];
                
                oneLabel.text = [NSString stringWithFormat:demoData[i] == (int)demoData[i]?@"%.2f":@"%.2f",demoData[i]];
                oneLabel.shadowColor = [UIColor darkGrayColor];
                oneLabel.shadowOffset = CGSizeMake(0.3, 0.3);
                [oneLabel setFont:[UIFont systemFontOfSize:10]];
                [oneLabel setAdjustsFontSizeToFitWidth:YES];
                [self addSubview:oneLabel];
                
                coor += 20*1.5;
            }
        }
    }
    
    //SecondArray
    
    if (_linesGraph) {
        double demoData[31] = {[[_secondArray objectAtIndex:0] doubleValue],[[_secondArray objectAtIndex:1] doubleValue],[[_secondArray objectAtIndex:2] doubleValue],[[_secondArray objectAtIndex:3] doubleValue],[[_secondArray objectAtIndex:4] doubleValue],[[_secondArray objectAtIndex:5] doubleValue],[[_secondArray objectAtIndex:6] doubleValue],[[_secondArray objectAtIndex:7] doubleValue],[[_secondArray objectAtIndex:8] doubleValue],[[_secondArray objectAtIndex:9] doubleValue],[[_secondArray objectAtIndex:10] doubleValue],[[_secondArray objectAtIndex:11] doubleValue]};
        yLabel.text = @"Month";
        double distanceNextYline = 20;
        double bizieLineAligm = 10;
        
        double nextX = 24;
        double downToXline = 75*3;
        double corectPointer1 = downToXline - demoData[0]*coefficient;
        //        NSLog(@"FirstPOint:  %f , %f",nextX,downToXline - demoData[0]*coefficient);
        
        CGMutablePathRef spadePath = CGPathCreateMutable();
        CGPathMoveToPoint(spadePath, NULL, nextX, downToXline - demoData[0]*coefficient);
        
        
        for (int i = 1; i < [_fistArray count]; i++) {
            CGPathAddCurveToPoint(spadePath, NULL, nextX+bizieLineAligm, corectPointer1, nextX+distanceNextYline-bizieLineAligm, downToXline - demoData[i]*coefficient, nextX+distanceNextYline, downToXline - demoData[i]*coefficient);
            nextX +=distanceNextYline;
            corectPointer1 = downToXline - demoData[i]*coefficient;
        }
        [[UIColor colorWithRed:229.0/255.0f green:168.0/255.0f blue:10.0/255.0f alpha:1.0f] set];
        CGContextSetLineWidth(context, 2);
        CGContextAddPath(context, spadePath);
        
        CGContextStrokePath(context);
        
        
        
    } else {
        
        
        
        if ([_secondArray count] == 12) {
            //seconArray
            double demoData2[12] = {[[_secondArray objectAtIndex:0] doubleValue],[[_secondArray objectAtIndex:1] doubleValue],[[_secondArray objectAtIndex:2] doubleValue],[[_secondArray objectAtIndex:3] doubleValue],[[_secondArray objectAtIndex:4] doubleValue],[[_secondArray objectAtIndex:5] doubleValue],[[_secondArray objectAtIndex:6] doubleValue],[[_secondArray objectAtIndex:7] doubleValue],[[_secondArray objectAtIndex:8] doubleValue],[[_secondArray objectAtIndex:9] doubleValue],[[_secondArray objectAtIndex:10] doubleValue],[[_secondArray objectAtIndex:11] doubleValue]};
            
            
            int coor = 18*1.5;
            for (int i = 0; i<12; i++) {
                CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:229.0f/255.0f green:168.0f/255.0f blue:10.0f/255.0f alpha:1].CGColor);
                CGContextSetRGBFillColor(context, 229.0f/255.0f, 168.0f/255.0f, 10.0f/255.0f, 1.0);
                CGMutablePathRef pathRef = CGPathCreateMutable();
                CGPathMoveToPoint(pathRef, NULL, coor, 75*3);
                CGPathAddLineToPoint(pathRef, NULL, coor, -demoData2[i]*coefficient+75*3);
                CGPathAddLineToPoint(pathRef, NULL, (coor+8), -demoData2[i]*coefficient+75*3);
                CGPathAddLineToPoint(pathRef, NULL, (coor+8), 75*3);
                CGPathCloseSubpath(pathRef);
                CGContextAddPath(context, pathRef);
                CGContextFillPath(context);
                CGContextAddPath(context, pathRef);
                CGContextStrokePath(context);
                CGContextSetShadow(context,CGSizeMake(2, 2) , 2);
                
                CGPathRelease(pathRef);
                int negCor;
                if (demoData2[i]>0) {
                    negCor = 15;
                } else {
                    negCor = 3;
                }
                UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake((coor-45), -demoData2[i]*coefficient+75*3-negCor, 50, 20)];
                secondLabel.textAlignment = NSTextAlignmentRight;
                secondLabel.backgroundColor = [UIColor clearColor];
                secondLabel.textColor = [UIColor colorWithRed:229.0f/255.0f green:168.0f/255.0f blue:10.0f/255.0f alpha:1];
                secondLabel.text = [NSString stringWithFormat:demoData2[i] == (int)demoData2[i]?@"%.2f":@"%.2f",demoData2[i]];
                secondLabel.shadowColor = [UIColor darkGrayColor];
                secondLabel.shadowOffset = CGSizeMake(0.3, 0.3);
                [secondLabel setFont:[UIFont systemFontOfSize:10]];
                [secondLabel setAdjustsFontSizeToFitWidth:YES];
                [self addSubview:secondLabel];
                
                coor += 20*1.5;
            }
        }
    }
}


@end
