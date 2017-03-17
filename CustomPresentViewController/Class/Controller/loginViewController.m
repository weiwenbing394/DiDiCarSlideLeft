//
//  loginViewController.m
//  CustomPresentViewController
//
//  Created by 大家保 on 2017/3/16.
//  Copyright © 2017年 大家保. All rights reserved.
//

#import "loginViewController.h"
#import "BaseNavigationController.h"

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitle:@"登陆"];
    
    UIButton *exit=[[UIButton alloc]initWithFrame:CGRectMake(50, 100, SCREENWIDTH-100, 50)];
    [exit setBackgroundColor:[UIColor redColor]];
    [exit setTitle:@"登陆" forState:0];
    [exit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [exit addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exit];
}

- (void)exit:(UIButton *)sender{
    AppDelegate *tempAppDelegate = KEYAPPDELEGATE;
    tempAppDelegate.window.rootViewController=[[BaseNavigationController alloc] initWithRootViewController:tempAppDelegate.LeftSlideVC];
}



@end
