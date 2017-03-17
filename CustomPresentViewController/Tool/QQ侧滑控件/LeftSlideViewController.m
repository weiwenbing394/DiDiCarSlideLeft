//
//  LeftSlideViewController.m
//  LeftSlideViewController
//
//  Created by huangzhenyu on 15/06/18.
//  Copyright (c) 2015年 huangzhenyu. All rights reserved.

#import "LeftSlideViewController.h"


@interface LeftSlideViewController ()<UIGestureRecognizerDelegate>{
    //原来的坐标
    CGFloat firstX;
}

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *leftTableview;

@end


@implementation LeftSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 @brief 初始化侧滑控制器
 @param leftVC 左视图控制器
 mainVC 中间视图控制器
 @result instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC andMainView:(UIViewController *)mainVC{
    if(self = [super init]){
        self.speedf = vSpeedFloat;
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        
        //滑动手势
        self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [self.pan setCancelsTouchesInView:YES];
        self.pan.delegate = self;
        [self.mainVC.view addGestureRecognizer:self.pan];
        
        //蒙版
        UIView *view = [[UIView alloc] init];
        view.frame = self.mainVC.view.bounds;
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        view.alpha = 0;
        self.contentView = view;
        [self.mainVC.view addSubview:view];
        
        //获取左侧tableview
        self.leftTableview=self.leftVC.view;
        self.leftTableview.frame=CGRectMake(-(kScreenWidth-kLeftPageDistance), 0, kScreenWidth-kLeftPageDistance, kScreenHeight);
        
        [self.view addSubview:self.mainVC.view];
        [self.view addSubview:self.leftVC.view];
        self.closed = YES;//初始时侧滑窗关闭
        
    }
    return self;
}



#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    CGPoint point = [rec translationInView:self.view];
    //拖动刚开始时
    if ([rec state] == UIGestureRecognizerStateBegan) {
        //刚开始的中心点坐标
        firstX= self.leftTableview.maxWidthX;
    }
    //根据视图位置判断是左滑还是右边滑动
    if ( (self.leftTableview.maxWidthX >= 0) && (self.leftTableview.maxWidthX <=(kScreenWidth - kLeftPageDistance))){
        NSLog(@"进来5");
        CGFloat maxX = firstX + point.x * self.speedf;
        if (maxX >=(kScreenWidth-kLeftPageDistance) ) {
            maxX = (kScreenWidth-kLeftPageDistance);
        }
        if (maxX <=0) {
            maxX =0;
        }
        self.leftTableview.maxWidthX = maxX;
        CGFloat tempAlpha = self.leftTableview.maxWidthX/(kScreenWidth-kLeftPageDistance);
        self.contentView.alpha = tempAlpha;
    }
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (self.leftTableview.maxWidthX >= vCouldChangeDeckStateDistance){
            [self openLeftView];
        }else{
            [self closeLeftView];
        }
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    if([touch.view isKindOfClass:[UITableView class]])
        return NO;
    else
        return YES;
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    if ((!self.closed) && (tap.state == UIGestureRecognizerStateEnded)){
        [UIView beginAnimations:nil context:nil];
        self.closed = YES;
        self.leftTableview.maxWidthX=0;
        self.contentView.alpha = 0;
        [UIView commitAnimations];
        [self removeSingleTap];
        
    }
    
}

#pragma mark - 修改视图位置
/**
 @brief 关闭左视图
 */
- (void)closeLeftView{
    [UIView beginAnimations:nil context:nil];
    self.closed = YES;
    self.leftTableview.maxWidthX=0;
    self.contentView.alpha = 0;
    [UIView commitAnimations];
    [self removeSingleTap];
    
}

/**
 @brief 打开左视图
 */
- (void)openLeftView;{
    [UIView beginAnimations:nil context:nil];
    self.closed = NO;
    self.leftTableview.maxWidthX=kScreenWidth-kLeftPageDistance;
    self.contentView.alpha =1;
    [UIView commitAnimations];
    [self disableTapButton];
   
}

#pragma mark - 行为收敛控制
- (void)disableTapButton{
    for (UIButton *tempButton in [_mainVC.view subviews]){
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!self.sideslipTapGes){
        //单击手势
        self.sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        [self.mainVC.view addGestureRecognizer:self.sideslipTapGes];
        self.sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
}

//关闭行为收敛
- (void) removeSingleTap{
    for (UIButton *tempButton in [self.mainVC.view  subviews]){
        [tempButton setUserInteractionEnabled:YES];
    }
    [self.mainVC.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}

/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */

- (void)setPanEnabled: (BOOL) enabled
{
    [self.pan setEnabled:enabled];
}


@end
