//
//  HomeViewController.m
//  XnkAppStart-Dome
//
//  Created by 千锋 on 16/5/2.
//  Copyright © 2016年 千锋. All rights reserved.
//

#import "HomeViewController.h"
#import "SubViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加一个label
    [self createPageLabel];
}
-(void)createPageLabel{
    UILabel *pageLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    [pageLabel setText:@"APP主页面"];
    [pageLabel setTextColor:[UIColor blueColor]];
    [pageLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:pageLabel];
}


@end
