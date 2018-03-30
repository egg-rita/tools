//
//  ViewController.m
//  ToolDemo
//
//  Created by 赵凯乐 on 2018/3/29.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+Category.h"
#import "UIButton+Layout.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(20, 20, 200, 50);
    btn.backgroundColor = [UIColor orangeColor];
    btn.custom_acceptEventInterval = 2.0;
    
    [btn addTarget:self action:@selector(btnaction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    for (int i = 0; i<9; i++) {
        
        UIButton *testbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [testbtn setImage:[UIImage imageNamed:@"icon-service"] forState:(UIControlStateNormal)];
        [testbtn setTitle:@"测试文字" forState:UIControlStateNormal];
        [testbtn KL_LayoutButtonWithEdgeInsetsStyle:(KLButtonEdgeInsetsStyleTop) andSpace:0];
    }
    
    
    
}
-(void)btnaction{
    
    NSLog(@"asdfadf");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
