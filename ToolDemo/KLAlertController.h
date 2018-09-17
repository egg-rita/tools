//
//  KLAlertController.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/2.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface KLAlertViewAnimate :UIPresentationController<UIViewControllerTransitioningDelegate>

@end


@interface KLAlertController : UIViewController

@property(nonatomic,strong)UIView *bgView;

-(void)configContentView:(UIView*)contentView;
@end
