//
//  LeftSlideViewController.h
//  LeftSlideViewController
//
//  Created by huangzhenyu on 15/06/18.
//  Copyright (c) 2015年 huangzhenyu. All rights reserved.

#define kScreenSize           [[UIScreen mainScreen] bounds].size
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

//打开左侧窗时，中视图(右视图)露出的宽度
#define kLeftPageDistance   100

//滑动距离大于此数时，状态改变（关--》开，或者开--》关）
#define vCouldChangeDeckStateDistance  ((kScreenWidth - kLeftPageDistance) / 2.0)

//滑动速度
#define vSpeedFloat   1

#import <UIKit/UIKit.h>
#import "UIView_extra.h"

@interface LeftSlideViewController : UIViewController

//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (nonatomic, assign) CGFloat speedf;

//左侧窗控制器
@property (nonatomic, strong) UIViewController *leftVC;

@property (nonatomic,strong) UIViewController *mainVC;

//点击手势控制器，是否允许点击视图恢复视图位置。默认为yes
@property (nonatomic, strong) UITapGestureRecognizer *sideslipTapGes;

//滑动手势控制器
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

//侧滑窗是否关闭(关闭时显示为主页)
@property (nonatomic, assign) BOOL closed;



/**
 @brief 初始化侧滑控制器
 @param leftVC 右视图控制器
 mainVC 中间视图控制器
 @result instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC;

/**
 @brief 关闭左视图
 */
- (void)closeLeftView;


/**
 @brief 打开左视图
 */
- (void)openLeftView;

/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */
- (void)setPanEnabled: (BOOL) enabled;

/**
 *  弹出presentViewController
 */
- (void)sliderViewControllerPresntViewController:(UIViewController *)topViewController animatd:(BOOL)aanimated;

/**
 *  push一个viewcontroller
 */
- (void)sliderViewControllerPushViewController:(UIViewController *)topViewController animatd:(BOOL)aanimated;

@end
