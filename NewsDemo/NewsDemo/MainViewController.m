//
//  ViewController.m
//  NewsDemo
//
//  Created by Tsz on 15/11/21.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "MainViewController.h"
#import "TSZHomeViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    [self setupChildController];
   
    //添加标题
    [self setupTitle];
    
    //设置默认显示的控制器
    TSZHomeViewController *defalutVc = [self.childViewControllers firstObject];
    
#warning 这里使用 self.view.bounds  {{0, 0}, {375, 667}}不能正常显示 ，使用 0, 0}, {600, 506} = self.contentScrollView.bounds
    
    defalutVc.view.frame = self.contentScrollView.bounds;
    
    [self.contentScrollView addSubview:defalutVc.view];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //隐藏水平条
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
}

- (void)setupChildController{
    
    TSZHomeViewController *vC1 = [[TSZHomeViewController alloc] init];
    vC1.title = @"1";
    
    [self addChildViewController:vC1];
  
    
    TSZHomeViewController *vC2 = [[TSZHomeViewController alloc] init];
    vC2.title = @"2";
    [self addChildViewController:vC2];
    
    TSZHomeViewController *vC3 = [[TSZHomeViewController alloc] init];
    vC3.title = @"3";
    [self addChildViewController:vC3];
    
    TSZHomeViewController *vC4 = [[TSZHomeViewController alloc] init];
    vC4.title = @"4";
    
    [self addChildViewController:vC4];
    TSZHomeViewController *vC5 = [[TSZHomeViewController alloc] init];
    vC5.title = @"5";
    
    
    [self addChildViewController:vC5];
    
    
}

- (void)setupTitle{
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat labelW = 80;
    CGFloat labelH = 30;
    CGFloat labelY = 0;
    
    for ( int i = 0; i < count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        
        [self.titleScrollView addSubview:label];
        
        
        CGFloat labelX = i * labelW;
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        //取出控制器
        UIViewController *vc =  self.childViewControllers[i];
        
        label.text = vc.title;
    }
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
}

@end
