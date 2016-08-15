//
//  weatherData.h
//  YTZG
//
//  Created by 李 恒 on 16/8/12.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weatherData : NSObject
@property (strong,nonatomic) NSString *strTempL;
@property (strong,nonatomic) NSString *strTempH;
@property (strong,nonatomic) NSString *strWeather;
@property (strong,nonatomic) NSString *fileName;
-(void)SetWeather;
@end
