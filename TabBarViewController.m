//
//  TabBarViewController.m
//  Mama
//
//  Created by 嘛嘛科技 on 16/2/22.
//  Copyright © 2016年 嘛嘛科技. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self CreateTabBarController];

}

#pragma mark -- 创建tabbar
-(void)CreateTabBarController{


    UIView *bgView = [[UIView alloc]initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:bgView atIndex:0];
  
    self.tabBar.opaque = YES;
    
    
    self.tabBar.tintColor = [UIColor colorWithRed:0/255.0 green:199/255.0 blue:205/255.0 alpha:1];
    
    //创建导航控制器并设置其根试图控制器
    MessageViewController *message = [[MessageViewController alloc]init];
    [self setupChildViewController:message title:@"聊天" imageName:@"02.png" selectedImageName:@"2.png"];

    
    //创建导航控制器并设置其的根视图控制器
    EaseConversationListViewController * order = [[EaseConversationListViewController alloc] init];
    [self setupChildViewController:order title:@"列表" imageName:@"05.png" selectedImageName:@"5.png"];
    
    //创建导航控制器并设置其的根视图控制器
    FriendViewController * life = [[FriendViewController alloc] init];
    [self setupChildViewController:life title:@"好友" imageName:@"06.png" selectedImageName:@"6.png"];
    
    //创建导航控制器并设置其的根视图控制器
    GroupMesageViewController * myself = [[GroupMesageViewController alloc] init];
   
    [self setupChildViewController:myself title:@"群聊" imageName:@"04.png" selectedImageName:@"4.png"];

 

}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
  
    return YES;
}
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //设置tabBarItem的主题
    childVc.tabBarItem.title = title;

    //设置tabBarItem的默认图片
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    //设置
    UIImage *imageSelected = [UIImage imageNamed:selectedImageName];
    
    childVc.tabBarItem.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    
    nav.navigationBar.hidden = YES;
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
