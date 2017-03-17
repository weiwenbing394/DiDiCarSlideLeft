//
//  TestController.m
//  CustomPresentViewController
//
//  Created by 大家保 on 2017/3/15.
//  Copyright © 2017年 大家保. All rights reserved.
//

#import "TestController.h"
#import "loginViewController.h"
#import "BaseNavigationController.h"


@interface TestController ()

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitle:self.titleString];
    [self addLeftButton];
    
    UIButton *exit=[[UIButton alloc]initWithFrame:CGRectMake(50, 100, SCREENWIDTH-100, 50)];
    [exit setTitle:@"退出" forState:0];
    [exit setBackgroundColor:[UIColor blueColor]];
    [exit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exit addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exit];
}


- (void)exit:(UIButton *)sender{
   AppDelegate *tempAppDelegate =KEYAPPDELEGATE;
   tempAppDelegate.LeftSlideVC=nil;
   tempAppDelegate.window.rootViewController=[[BaseNavigationController alloc]initWithRootViewController:[[loginViewController alloc]init]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
