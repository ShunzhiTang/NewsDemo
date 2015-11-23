//
//  TSZTitleLabel.m
//  NewsDemo
//
//  Created by Tsz on 15/11/22.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "TSZTitleLabel.h"

@implementation TSZTitleLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:19];
        
//        self.textColor = [UIColor redColor];
        
        //交互
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setScale:(CGFloat)scale{
    
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    
    //大小渐变
    CGFloat minHScale = 0.7;
    
    CGFloat currentScale = minHScale + scale *(1- minHScale);
    
    self.transform = CGAffineTransformMakeScale(currentScale, currentScale);
}


@end
