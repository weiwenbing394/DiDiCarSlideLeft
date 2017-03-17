//
//  XWInteractiveTransition.h
//  CustomPresentViewController
//
//  Created by 大家保 on 2017/3/14.
//  Copyright © 2017年 大家保. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TransitionType) {
    TransitionTypePresent = 0,//管理present动画
    TransitionTypeDismiss//管理dismiss动画
};

@interface XWInteractiveTransition : NSObject<UIViewControllerAnimatedTransitioning>
//图片资源
@property (nonatomic,strong)id resource;
//动画类型
@property (nonatomic,assign)TransitionType transitionType;
//原始位置
@property (nonatomic,assign)CGRect startRect;
//初始化方法
+(instancetype)transitionWithTransitionType:(TransitionType)type;

- (instancetype)initWithTransitionType:(TransitionType)type;

@end
