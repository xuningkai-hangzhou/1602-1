//
//  SubViewController.m
//  XnkAppStart-Dome
//
//  Created by 千锋 on 16/5/2.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "SubViewController.h"
#import "HomeViewController.h"

#define imageNum 4
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
#pragma make 创建scrollView

@interface SubViewController ()
@property(nonatomic,strong)UIPageControl * pageControl;
@end

@implementation SubViewController

-(void)loadView
{
    [super loadView];
    //图层一
    [self createAnimalView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //图层二
    [self createScrollView];
    [self createPageContorl];
}


#pragma make 创建app初始动画
-(void)createAnimalView
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView setImage:[UIImage imageNamed:@"new_feature_background"]];
    [self.view addSubview:imageView];
    
    [self.view setUserInteractionEnabled:YES];
}

-(void)createScrollView
{
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    //设置imageView的范围
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width*imageNum, 0)];
    
    //在滚动视图中添加image
    for (NSInteger i=0; i<imageNum; i++) {
        UIImageView *pageImageView=[[UIImageView alloc] initWithFrame:CGRectMake(i*WIDTH, 0, WIDTH, HEIGHT)];
        [pageImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%ld.png",i + 1]]];
        if (i==imageNum - 1) {
            //添加跳转的页面
            [self createSkipButton:pageImageView];
        }
        [scrollView addSubview:pageImageView];
    }
    [scrollView setPagingEnabled:YES];
    //弹性效果实效
    [scrollView setBounces:NO];
    //移除水平指示滚动
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    
    //设置代理,以便于滑动时改变pageControl
    [scrollView setDelegate:self];
    [self.view addSubview:scrollView];
}

#pragma make 创建pageContorl翻页指示器
-(void)createPageContorl
{
    _pageControl=[[UIPageControl alloc] init];
    //位置
    [_pageControl setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height * 0.9)];
    [_pageControl setNumberOfPages:imageNum];
    //设置指示器默认颜色
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    //设置当前页指示器的颜色
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [self.view addSubview:_pageControl];
}

#pragma mark 实现scrollView的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    [_pageControl setCurrentPage:index];
}

#pragma mark 创建最后一页的“立即体验”按钮
-(void)createSkipButton:(UIImageView*)pageImageView{
    //父子视图交互开关，开启
    [pageImageView setUserInteractionEnabled:YES];
    UIButton * skipButton=[[UIButton alloc] init];
    //设置背景图片
    UIImage *backImage=[UIImage imageNamed:@"new_feature_finish_button"];
    [skipButton setBackgroundImage:backImage forState:UIControlStateNormal];
    
    //设置button位置，坐标
    [skipButton setBounds:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    [skipButton setCenter:CGPointMake(WIDTH/2, HEIGHT*0.8)];
    
    //消息响应
    [skipButton addTarget:self action:@selector(btClick) forControlEvents:UIControlEventTouchUpInside];
    //添加到pageImageView
    [pageImageView addSubview:skipButton];
    
}

-(void)btClick
{
    //准备动画
    CATransition * animation = [CATransition animation];
    //动画执行时间
    animation.duration = 0.5;
    //动画类型
    animation.type = @"push";
    //动画方向
    animation.subtype = @"fromRight";
    
    [self.view.superview.layer addAnimation:animation forKey:@""];
    UIViewController * home = self.parentViewController.childViewControllers[1];
    
    //从子视图切换到vc
    [self.parentViewController transitionFromViewController:self toViewController:home duration:1 options:0 animations:nil completion:nil];
}

@end
