//
//  XWInteractiveTransition.m
//  CustomPresentViewController
//
//  Created by 大家保 on 2017/3/14.
//  Copyright © 2017年 大家保. All rights reserved.
//

#import "XWInteractiveTransition.h"
#import "UIView+ScreensShot.h"
#import "UIImage+ImageEffects.h"

@implementation XWInteractiveTransition

//初始化方法
+(instancetype)transitionWithTransitionType:(TransitionType)type{
    XWInteractiveTransition *xwInteractiveTransition=[[XWInteractiveTransition alloc]initWithTransitionType:type];
    return xwInteractiveTransition;
};

- (instancetype)initWithTransitionType:(TransitionType)type{
    if (self=[super init]) {
        self.transitionType=type;
    }
    return self;
};

#pragma mark UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
};

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    switch (_transitionType) {
        case TransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case TransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
        default:
            break;
    }
};


//实现present动画逻辑代码
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //目标控制器
    UIViewController *toVC=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //资源控制器
    UIViewController *fromVC=[transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    //获取资源控制器的屏幕截图
    UIImage *image=[fromVC.view screenShot];
    //创建一个过渡视图
    UIImageView *snapView=[[UIImageView alloc]initWithImage:image];
    snapView.frame=fromVC.view.frame;
    snapView.alpha=1;
    //隐藏资源视图
    fromVC.view.hidden=YES;
    toVC.view.alpha=0;
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView=[transitionContext containerView];
    [containerView addSubview:snapView];
    [containerView addSubview:toVC.view];
    //创建放大的图片视图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:_startRect];
    imageView.image=_resource;
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.alpha=1;
    //创建下部模糊视图
    UIImage *blur = [_resource applyExtraLightEffect];
    UIImageView *bottomImageView=[[UIImageView alloc]initWithFrame:_startRect];
    bottomImageView.image=blur;
    //将创建的两个视图加入到snapView
    [snapView addSubview:bottomImageView];
    [snapView addSubview:imageView];
    //开始动画
    [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^{
        imageView.frame=CGRectMake(0, 0, toVC.view.frame.size.width, (toVC.view.frame.size.height/2.0)+40);
        bottomImageView.frame=CGRectMake(0, CGRectGetMaxY(imageView.frame), toVC.view.frame.size.width, (toVC.view.frame.size.height-imageView.frame.size.height));
    }completion:nil];
    [UIView animateWithDuration:0.2 delay:0.3 options:0 animations:^{
        toVC.view.alpha=1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [snapView removeFromSuperview];
    }];
    
}

//实现dismiss动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //目标视图
    UIViewController *toVC=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //源视图
    UIViewController *fromVC=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //获取目标视图的屏幕快照
    UIImage *image=[toVC.view screenShot];
    //创建一个过渡视图
    UIImageView *snapView=[[UIImageView alloc]initWithImage:image];
    snapView.frame=fromVC.view.frame;
    //隐藏源视图
    fromVC.view.hidden=YES;
    toVC.view.hidden=NO;
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView=[transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:snapView];
    //创建上面的图像和模糊层
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, toVC.view.frame.size.width, (toVC.view.frame.size.height/2.0)+40)];
    imageView.image=_resource;
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.alpha=1;
    //创建下部模糊视图
    UIImage *blur = [_resource applyExtraLightEffect];
    UIImageView *bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), toVC.view.frame.size.width, (toVC.view.frame.size.height-imageView.frame.size.height))];
    bottomImageView.image=blur;
    //过渡视图添加子视图
    [snapView addSubview:bottomImageView];
    [snapView addSubview:imageView];
    //开始动画
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^{
        imageView.frame=_startRect;
        bottomImageView.frame=_startRect;
    } completion:nil];
    
    [UIView animateKeyframesWithDuration:0.2 delay:0.3 options:0 animations:^{
        snapView.alpha=0;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
            toVC.view.hidden=NO;
            fromVC.view.hidden=YES;
            [snapView removeFromSuperview];
        }
    }];

}

@end
