//
//  MessageViewController.m
//  huanxinDemo
//
//  Created by jefactoria on 16/9/26.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "MessageViewController.h"
#import "ChatViewController.h"
#import "EaseMessageViewController.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"聊天";
    


}
- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(100, 200, 200, 100);
    [sendBtn setTitle:@"快来聊天吧" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    
    
}
-(void)sendMessage{
    

   ChatViewController  *vc=[[ChatViewController alloc]initWithConversationChatter:@"hanwei" conversationType:EMConversationTypeChat];
  

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
