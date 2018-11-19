//
//  KLTranstionDelegate.m
//  ToolDemo
//
//  Created by PC-013 on 2018/10/11.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLTranstionDelegate.h"
#import "UIViewController+KLTranstion.h"
#import "KLAnimationAlert.h"
@implementation KLTranstionDelegate
+(instancetype)shareInstance{
    static KLTranstionDelegate *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[KLTranstionDelegate alloc]init];
    });
    return _shareInstance;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    id<UIViewControllerAnimatedTransitioning> objc = nil;
    switch (presented.animationStyle) {
        case KLTranstionStyleAlert://弹框
            objc = [[KLAnimationAlert alloc]init];
            break;
            
        default:
            break;
    }
    
    return objc;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    id<UIViewControllerAnimatedTransitioning> objc = nil;
    switch (dismissed.animationStyle) {
        case KLTranstionStyleAlert://弹框
            objc = [[KLAnimationAlert alloc]init];
            break;
            
        default:
            break;
    }
    return objc;
}
@end
