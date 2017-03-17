//
//  BaseViewController.m
//  BaobiaoDog
//
//  Created by 大家保 on 16/7/13.
//  Copyright © 2016年 大家保. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UILabel *titleLabel;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavBar];
}
/**
 *  导航栏初始化
 */
- (void)initNavBar
{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
}


/**
 *  添加返回按钮
 */
- (void)addLeftButton{
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    UIButton *leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [leftButton setImage:[UIImage imageNamed:@"return-arr"] forState:0];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
};

/**
 *  添加左边按钮
 *
 */
- (void)addLeftBarButton:(NSString *)imageName{
    UIButton *leftButton=[[UIButton alloc]initWithFrame:CGRectMake(5, 20, 45, 44)];
    leftButton.tag=20000;
    [leftButton setImage:[UIImage imageNamed:imageName] forState:0];
    [leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
};


/**
 *  添加右边按钮
 *
 *  @param rightStr 右边按钮标题
 */
- (void)addRightButton:(NSString *)rightStr{
    CGSize rightStrSzie=[rightStr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil]];
    UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-25-rightStrSzie.width, 20, rightStrSzie.width+20, 44)];
    rightButton.tag=10000;
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [rightButton setTitle:rightStr forState:0];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:0];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightButton addTarget:self action:@selector(forward:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
};
/**
 *  添加右边按钮（图片）
 */
- (void)addRightButtonWithImageName:(NSString *)imageName{
    UIButton *RightButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH-45, 20, 45, 44)];
    RightButton.tag=10000;
    [RightButton setImage:[UIImage imageNamed:imageName] forState:0];
    [RightButton addTarget:self action:@selector(forward:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RightButton];
}
/**
 *  添加标题
 *
 *  @param title 基类标题
 */
- (void)addTitle:(NSString *)title{
    
    if (titleLabel == nil) { //在某些页面需要修改title，所以就修改了一下
        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 20, SCREENWIDTH-120, 43.5)];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.font=[UIFont systemFontOfSize:18];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    titleLabel.text=title;
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 63.5, SCREENWIDTH, 0.5)];
    line.backgroundColor=[UIColor colorWithRed:181/255.0 green:175/255.0 blue:168/255.0 alpha:1];
    [self.view addSubview:line];
    [self.view addSubview:titleLabel];
};

/**
 *  左按钮返回事件
 */
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  leftBarButton点击事件 ,子类重写
 *
 */
- (void)leftClick:(UIButton *)btn{
    
}
/**
 *  右边按钮事件：子类重写
 *
 *  @param button 触发按钮
 */
- (void)forward:(UIButton *)button{
    
}
/**
 *  重连成功的回调（由子类重写）
 */
- (void)ConnectSuccess{
    
}
/**
 *  去除字符串空格
 *
 *  @param str 去处空格前的字符
 *
 *  @return 去处空格后的字符
 */
- (NSString *)clearSpace:(NSString *)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];;
}




#pragma mark - 右侧滑动到某个控制器
/** 右侧滑动到第几个视图控制器  从0开始计算 */
- (void)rightSlideToViewControllerIndex:(NSInteger)index {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    if (array.count <= index+2) {
        return;
    }
    while(array.count > index+2) {
        [array removeObjectAtIndex:index+1];
    }
    [self.navigationController setViewControllers: array];
}


/** 右侧滑动到根部视图控制器 */
- (void)rightSlideToRootController {
    [self rightSlideToViewControllerIndex:0];
}



-(CGFloat)changeStationWidth:(NSString *)string anWidthTxtt:(CGFloat)widthText anfont:(CGFloat)fontSize{
    
    UIFont * tfont = [UIFont systemFontOfSize:fontSize];
    
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    
    CGSize size = CGSizeMake(widthText,CGFLOAT_MAX);
    
    //    获取当前文本的属性
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    
    //ios7方法，获取文本需要的size，限制宽度
    
    CGSize  actualsize =[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    return actualsize.height;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.view.window==nil) {
        self.view=nil;
    }
    
}

@end
