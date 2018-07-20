//
//  KLAlertController.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/2.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLAlertController.h"

@interface KLAlertController ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *contentView;
@end

@implementation KLAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    NSArray *superSubViews = self.view.superview.subviews;
//    NSLog(@"%@",superSubViews);
    self.bgView = [superSubViews firstObject];
//    self.bgView.backgroundColor = [UIColor colorWithRed:0.2 green:.5 blue:.2 alpha:0.3];
//    self.contentView = [superSubViews objectAtIndex:1];
//    self.view.frame = CGRectZero;
//    self.view = self.contentView;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

-(void)configContentView:(UIView *)subview{
    NSLog(@"%@",self.contentView);
    [self.bgView addSubview:subview];
//    self.view.backgroundColor= [UIColor redColor];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    NSLog(@"%@控制器销毁了!!",self.view);
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
