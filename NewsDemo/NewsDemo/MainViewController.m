//
//  ViewController.m
//  NewsDemo
//
//  Created by Tsz on 15/11/21.
//  Copyright © 2015年 Tsz. All rights reserved.

#import "MainViewController.h"
#import "TSZHomeViewController.h"
#import "TSZTitleLabel.h"

@interface MainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.contentScrollView.delegate = self;
    
    //添加子控制器
    [self setupChildController];
   
    //添加标题
    [self setupTitle];
    
    //设置默认显示的控制器
    TSZHomeViewController *defalutVc = [self.childViewControllers firstObject];
    //默认选择的title的颜色
    TSZTitleLabel *label = self.titleScrollView.subviews.firstObject;
    label.scale = 1.0;
    
    
    
#warning 这里使用 self.view.bounds  {{0, 0}, {375, 667}}不能正常显示 ，使用 0, 0}, {600, 506} = self.contentScrollView.bounds
    
    defalutVc.view.frame = self.contentScrollView.bounds;
    
    [self.contentScrollView addSubview:defalutVc.view];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //分页
    self.contentScrollView.pagingEnabled = YES;
    
    //隐藏水平条
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    //设置内容的size
    
    CGFloat  screen = [UIScreen mainScreen].bounds.size.width;
    CGFloat contentW = self.childViewControllers.count * screen ;
    
    self.contentScrollView.contentSize  = CGSizeMake(contentW, 0);
}

- (void)setupChildController{
    
    TSZHomeViewController *vC1 = [[TSZHomeViewController alloc] init];
    vC1.title = @"科技";
    
    [self addChildViewController:vC1];
  
    
    TSZHomeViewController *vC2 = [[TSZHomeViewController alloc] init];
    vC2.title = @"民生";
    [self addChildViewController:vC2];
    
    TSZHomeViewController *vC3 = [[TSZHomeViewController alloc] init];
    vC3.title = @"政治";
    [self addChildViewController:vC3];
    
    TSZHomeViewController *vC4 = [[TSZHomeViewController alloc] init];
    vC4.title = @"军事";
    
    [self addChildViewController:vC4];
    TSZHomeViewController *vC5 = [[TSZHomeViewController alloc] init];
    vC5.title = @"娱乐";
    
    [self addChildViewController:vC5];
    
    TSZHomeViewController *vC6 = [[TSZHomeViewController alloc] init];
    vC6.title = @"体育";
    
    
    [self addChildViewController:vC6];
    

    TSZHomeViewController *vC7 = [[TSZHomeViewController alloc] init];
    vC7.title = @"教育";
    
    
    [self addChildViewController:vC7];
    
    
}

- (void)setupTitle{
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat labelW = 80;
    CGFloat labelH = 30;
    CGFloat labelY = 0;
    
    for ( int i = 0; i < count; i++) {
        
        TSZTitleLabel *label = [[TSZTitleLabel alloc] init];
        
        label.tag = i;
        [self.titleScrollView addSubview:label];
        
        
        CGFloat labelX = i * labelW;
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        //取出控制器
        UIViewController *vc =  self.childViewControllers[i];
        
        label.text = vc.title;
        
         //设置手势 点击手势识别
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
    
}

- (void)labelClick:(UITapGestureRecognizer *)recongnizer{
    
    //获取点击的label
    TSZTitleLabel *label = (TSZTitleLabel *)recongnizer.view;
    CGFloat offset = label.tag * self.contentScrollView.frame.size.width;
    
    [self.contentScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}

#pragma mark: 代理方法
/**
 * 动画结束时调用
 *
 * @param scrollView: 手动不会触发这个事件
 
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIViewController *vc = self.childViewControllers[index];
    
    //滚动标题
    TSZTitleLabel *label = self.titleScrollView.subviews[index];
    CGFloat offsetX = label.center.x - self.titleScrollView.frame.size.width * 0.5;
    
    CGFloat maxOffset = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width;
    
    if (offsetX < 0) {
        offsetX = 0;
    }else if(offsetX > maxOffset){
        offsetX = maxOffset;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    //遍历把其他的label设置成黑色
    
    [self.titleScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx != index) {
            TSZTitleLabel *other = self.titleScrollView.subviews[idx];
            other.scale = 0.0;
        
        }
    }];
    
    
    if (vc.view.superview) {
        return;
    }
    
    CGFloat vcW = scrollView.frame.size.width;
    CGFloat vcH = scrollView.frame.size.height;
    CGFloat vcX = scrollView.frame.size.width * index;
    CGFloat vcY = 0;
    
    vc.view.frame = CGRectMake(vcX, vcY, vcW, vcH);
    
    [scrollView addSubview:vc.view];
    
}

//手动动画结束调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     [self scrollViewDidEndScrollingAnimation:scrollView];
}

//只要滚 就一直掉用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat value = ABS(self.contentScrollView.contentOffset.x / self.contentScrollView.frame.size.width);
    
    //左边的索引文字
    NSUInteger leftIndex =  (NSUInteger)(self.contentScrollView.contentOffset.x / self.contentScrollView.frame.size.width);
    
    //右边索引
    NSUInteger rightIndex = leftIndex + 1 ;

    CGFloat rightScale = value- leftIndex;
    
    
    //比例
    CGFloat leftScale = 1 - rightScale;
    
    TSZTitleLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    leftLabel.scale = leftScale;
    
    if (rightIndex < self.titleScrollView.subviews.count) {
        TSZTitleLabel *rightLabel = self.titleScrollView.subviews[rightIndex];
        rightLabel.scale = rightScale;
    }    
}


@end
