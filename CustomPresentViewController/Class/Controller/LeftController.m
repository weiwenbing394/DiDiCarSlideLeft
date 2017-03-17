//
//  LeftController.m
//  CustomPresentViewController
//
//  Created by 大家保 on 2017/3/15.
//  Copyright © 2017年 大家保. All rights reserved.
//

#import "LeftController.h"
#import "TestController.h"
#import "DetailViewController.h"

@interface LeftController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableview;
}

@end

@implementation LeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor clearColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-kLeftPageDistance, kScreenHeight)];
    imageview.image = [UIImage imageNamed:@"leftbackiamge"];
    [self.view addSubview:imageview];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-kLeftPageDistance, kScreenHeight) style:UITableViewStyleGrouped];
    tableview.backgroundColor=[UIColor clearColor];
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"了解会员特权";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"QQ钱包";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"个性装扮";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"我的相册";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"我的文件";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"设置";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TestController *vc = [[TestController alloc] init];
    vc.titleString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    vc.hidesBottomBarWhenPushed = YES;
    
    AppDelegate *tempAppDelegate =KEYAPPDELEGATE;
    //滴滴打车样式
    [tempAppDelegate.LeftSlideVC.navigationController pushViewController:vc animated:YES];
    //腾讯QQ样式
//    [tempAppDelegate.LeftSlideVC closeLeftView];
//    UITabBarController *tabbar=(UITabBarController *)tempAppDelegate.LeftSlideVC.mainVC;
//    [tabbar.selectedViewController pushViewController:vc animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 180)];
    view.backgroundColor = [UIColor clearColor];
    
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(CGRectGetWidth(view.frame)/2-25, 40, 50, 50);
    imageButton.layer.cornerRadius = 25;
    [imageButton setBackgroundImage:[UIImage imageNamed:@"会员头像"] forState:UIControlStateNormal];
    [view addSubview:imageButton];
    [imageButton addTarget:self action:@selector(imgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageButton.frame)+5, tableView.bounds.size.width, 20)];
    nameLabel.text = @"会员名称";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    return view;
}


- (void)imgButtonAction:(UIButton *)sender {
    CGRect headRect=[tableview rectForFooterInSection:0];
    CGRect rect=[tableview convertRect:headRect fromView:self.view];
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.resoource=sender.currentBackgroundImage;
    vc.startFrame=rect;
    
    AppDelegate *tempAppDelegate = KEYAPPDELEGATE;
    //滴滴打车样式
    [tempAppDelegate.LeftSlideVC presentViewController:vc animated:YES completion:^{
    }];
    //腾讯qq样式
//    UITabBarController *tabbar=(UITabBarController *)tempAppDelegate.LeftSlideVC.mainVC;
//    [tabbar.selectedViewController presentViewController:vc animated:NO completion:^{
//        [tempAppDelegate.LeftSlideVC closeLeftView];
//    }];
}




@end
