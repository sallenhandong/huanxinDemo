//
//  ViewController.m
//  huanxinDemo
//
//  Created by jefactoria on 16/9/23.
//  Copyright © 2016年 djmulder. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)talkMessgae:(id)sender {
    
    ChatViewController *vc=[[ChatViewController alloc]initWithConversationChatter:@"testOne" conversationType:EMConversationTypeChat];
    
   [self presentViewController:vc animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
