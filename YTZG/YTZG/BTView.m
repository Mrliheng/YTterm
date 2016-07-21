//
//  BTView.m
//  YTZG
//
//  Created by 李 恒 on 16/7/17.
//  Copyright © 2016年 李 恒. All rights reserved.
//

#import "BTView.h"
@implementation BTView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _BTImageView = [[UIImageView alloc]init];
        _BTLabel = [[UILabel alloc]init];
        _BTImageView.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
        _BTLabel.frame = CGRectMake(0, self.frame.size.width+4, self.frame.size.width, self.frame.size.height-self.frame.size.width-4);
        _BTLabel.textColor = [UIColor blackColor];
        _BTLabel.textAlignment = NSTextAlignmentCenter;
        _BTLabel.font = [UIFont systemFontOfSize:_BTLabel.frame.size.width/5];
        [self addSubview:_BTImageView];
        [self addSubview:_BTLabel];
    }
    return self;
}
@end
