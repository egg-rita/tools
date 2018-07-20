//
//  KLImageBrowerVC.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLImageBrowserVC.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "KLImageBrowserAnimatedTransitioning.h"

#import "KLImageBrowserDownloader.h"


static CGFloat _maxDisplaySize = 3500;
static BOOL _showStatusBar = NO;    //改控制器是否需要隐藏状态栏
static BOOL _isControllerPreferredForStatusBar = YES; //状态栏是否是控制器优先
static BOOL _statusBarIsHideBefore = NO;    //状态栏在模态切换之前是否隐藏

@interface KLImageBrowserVC ()<KLImageBrowserDelegate,>

@end

@implementation KLImageBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
