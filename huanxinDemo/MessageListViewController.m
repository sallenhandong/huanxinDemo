//
//  MessageListViewController.m
//  huanxinDemo
//
//  Created by jefactoria on 16/9/26.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "MessageListViewController.h"
#import "EaseConversationListViewController.h"
@interface MessageListViewController ()

@end

@implementation MessageListViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"列表";

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(100, 200, 200, 100);
    [sendBtn setTitle:@"获取会话列表" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(getListMyMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
  
}
-(void)getListMyMessage{

    EaseConversationListViewController *vc = [[EaseConversationListViewController alloc]init];
    
    [self .navigationController pushViewController:vc animated:YES];
    


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
