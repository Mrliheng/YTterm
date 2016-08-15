//
//  weatherData.m
//  YTZG
//
//  Created by 李 恒 on 16/8/12.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "weatherData.h"

@implementation weatherData
-(void)SetWeather
{
    NSError *error;
    //获取温度
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.thinkpage.cn/v3/weather/daily.json?key=poaufucs3ixc3c6x&location=hangzhou&language=zh-Hans&unit=c&start=0&days=1"]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    //    NSLog(@"%@",weatherDic);
    NSArray *weatherInfo = [weatherDic objectForKey:@"results"];
    
    
    //实时天气情况
    //加载一个NSURL对象
    NSURLRequest *requestNow = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.thinkpage.cn/v3/weather/now.json?key=poaufucs3ixc3c6x&location=hangzhou&language=zh-Hans&unit=c"]];
    //将请求的url数据放到NSData对象中
    NSData *responseNow = [NSURLConnection sendSynchronousRequest:requestNow returningResponse:nil error:nil];
    //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
    NSDictionary *weatherDicNow = [NSJSONSerialization JSONObjectWithData:responseNow options:NSJSONReadingMutableLeaves error:&error];
    //    NSLog(@"%@",weatherDic);
    NSArray *WeatherInfoNow = [weatherDicNow objectForKey:@"results"];
    
    if(weatherInfo !=nil&&WeatherInfoNow !=nil)
    {
        NSDictionary *weatherInfodic = [weatherInfo objectAtIndex:0];
        NSArray *dailyArray = [weatherInfodic objectForKey:@"daily"];
//        NSLog(@"%@",dailyArray);
        
        NSDictionary *daily = [dailyArray objectAtIndex:0];
        _strTempH = [daily objectForKey:@"high"];
        _strTempL = [daily objectForKey:@"low"];
        
        
        NSDictionary *weatherInfodicNow = [WeatherInfoNow objectAtIndex:0];
        NSDictionary *nowdic = [weatherInfodicNow objectForKey:@"now"];
        _strWeather = [nowdic objectForKey:@"text"];

        if(NSNotFound != [_strWeather rangeOfString:@"晴"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@",@"晴.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"多云"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"多云.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"阴"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"阴.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"雨"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"雪"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"小雪.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"雷"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"雷雨.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"雾"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"雾.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"大雪"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"大雪.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"大雨"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"中雪"].location)
        {
            _fileName = [[NSString alloc]initWithFormat:@"%@",@"中雪.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"中雨"].location)
        {
            _fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"小雪"].location)
        {
            _fileName = [[NSString alloc]initWithFormat:@"%@",@"小雪.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"小雨"].location)
        {
            _fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"雨加雪"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"雨夹雪.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"阵雨"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"雷阵雨"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"雷阵雨.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"大雨转晴"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨转晴.png"];
        }
        if(NSNotFound != [_strWeather rangeOfString:@"阴转晴"].location)
        {
            _fileName =[[NSString alloc]initWithFormat:@"%@", @"阴转晴.png"];
        }
    }
}
@end
