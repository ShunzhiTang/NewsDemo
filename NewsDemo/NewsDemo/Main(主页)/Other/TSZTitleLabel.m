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
        
        self.textColor = [UIColor redColor];
        
        //交互
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
