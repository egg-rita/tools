//
//  KLAnimationAlert.m
//  ToolDemo
//
//  Created by PC-013 on 2018/10/11.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLAnimationAlert.h"

@implementation KLAnimationAlert
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.35;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //获取转场舞台(平台)
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *fromController = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromController.view;
    UIView *toView = toController.view;
    
    //入场动效
    if (toController.isBeingPresented) {
        [containerView addSubview:toView];
        toView.alpha = 0.f;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            toView.alpha = 1;
            
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
            
        }];
    }
    //出场动效
    if (fromController.isBeingDismissed) {
        
        [containerView addSubview:fromView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.alpha = 0.f;
            
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}
@end
