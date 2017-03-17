//
//  DetailViewController.m
//  CustomPresentViewController
//
//  Created by 大家保 on 2017/3/14.
//  Copyright © 2017年 大家保. All rights reserved.
//

#import "DetailViewController.h"
#import "XWInteractiveTransition.h"


@interface DetailViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic,strong)XWInteractiveTransition  *transitionManage;

@end

@implementation DetailViewController


- (instancetype)init{
    if (self=[super init]) {
        self.transitioningDelegate=self;
        self.modalPresentationStyle=UIModalPresentationCustom;
        _transitionManage=[[XWInteractiveTransition alloc]init];
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _transitionManage.transitionType=TransitionTypePresent;
    return _transitionManage;
};

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _transitionManage.transitionType=TransitionTypeDismiss;
    return _transitionManage;
};

- (void)setResoource:(id)resources{
    _resoource = resources;
    _transitionManage.resource =resources;
}

- (void)setStartFrame:(CGRect)startFrame{
    _startFrame = startFrame;
    _transitionManage.startRect = startFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initUI];
}

- (void)initUI{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT/2.0+40)];
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.image=self.resoource;
    [self.view addSubview:imageView];
    
    UIView *maskView=[[UIView alloc]initWithFrame:imageView.bounds];
    maskView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
    [imageView addSubview:maskView];
    
    UIImageView *bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), SCREENWIDTH, SCREENHEIGHT/2.0-40)];
    bottomImageView.image=self.resoource;
    UIVisualEffectView *effectView=[[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame=bottomImageView.bounds;
    effectView.alpha=1;
    bottomImageView.contentMode=UIViewContentModeScaleAspectFill;
    [bottomImageView addSubview:effectView];
    [self.view addSubview:bottomImageView];
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:bottomImageView.bounds];
    titleLabel.numberOfLines=0;
    titleLabel.text=@"我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字我是测试文字";
    titleLabel.textColor=[UIColor blackColor];
    [bottomImageView addSubview:titleLabel];
    
    UIButton *closeButtom=[[UIButton alloc]initWithFrame:CGRectMake(15, 20, 100, 44)];
    [closeButtom setTitle:@"关闭" forState:0];
    [closeButtom setTitleColor:[UIColor whiteColor] forState:0];
    [closeButtom.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [closeButtom setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [closeButtom addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButtom];
    
    
   
}


- (void)close:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
