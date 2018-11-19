//
//  KLAlertController.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/2.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLAlertController.h"
#import "UIViewController+KLTranstion.h"

@interface KLAlertController ()

@end

@implementation KLAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    self.view.backgroundColor = [UIColor clearColor];
    
    
    self.bgView.frame = self.view.bounds;
    [self.view addSubview:self.bgView];

}
-(void)configContentView:(UIView*)contentView{
    if (!contentView) {
        return;
    }
    [self.view addSubview:contentView];
}


#pragma mark - getter
- (UIView *)bgView{
    if (!_bgView) {
        _bgView= [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.4;
        
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

-(void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
