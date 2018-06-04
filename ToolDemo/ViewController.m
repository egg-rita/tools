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
#import "UIView+KLLayer.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //避免重复点击
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(20, 20, 200, 50);
    [btn setTitle:@"间隔2秒点击" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.backgroundColor = [UIColor orangeColor];
    [btn kl_borderWithRadius:4 andLineWidth:2 andStrokeColor:[UIColor greenColor]];
    btn.custom_acceptEventInterval = 2.0;
    
    [btn addTarget:self action:@selector(btnaction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    CGFloat btnW = (self.view.bounds.size.width-40)/3.0;
    for (int i = 0; i<3; i++) {
        
        UIButton *testbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        testbtn.frame = CGRectMake(btnW*(i%3)+10*(i%3+1), 100 + 70*(i/3), btnW, 60);
        [testbtn setImage:[UIImage imageNamed:@"icon-service"] forState:(UIControlStateNormal)];
        [testbtn setTitle:[NSString stringWithFormat:@"测试 %d",i] forState:UIControlStateNormal];
        testbtn.backgroundColor = [UIColor magentaColor];
        
//        [testbtn kl_systemShadowWithOffset:CGSizeMake(0, 0)
//                                 andRadius:5
//                                  andColor:[UIColor blackColor]
//                                andopacity:.8];
        [testbtn kl_borderWithRadius:3 andLineWidth:2 andStrokeColor:[UIColor redColor]];
        [testbtn KL_LayoutButtonWithEdgeInsetsStyle:(KLButtonEdgeInsetsStyleBottom) andSpace:10];
        [self.view addSubview:testbtn];
    }
    
    
    
}
-(void)btnaction{
    
    NSLog(@"间隔2秒点击");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
