//
//  UIViewController+KLTranstion.m
//  ToolDemo
//
//  Created by PC-013 on 2018/10/11.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "UIViewController+KLTranstion.h"
#import "KLTranstionDelegate.h"
#import <objc/runtime.h>

static char * const klTransitionDelegateKey = "klTransitionDelegateKey";
static char * const klAnimationStyleKey     = "klAnimationStyleKey";
@interface UIViewController ()
@property(nonatomic,strong)KLTranstionDelegate *transtionDelegate;
@end
@implementation UIViewController (KLTranstion)
-(void)klPresentViewController:(UIViewController*)ctr transtionStyle:(KLTranstionStyle)style completion:(void(^)(void))completion{
    
    self.transtionDelegate = [KLTranstionDelegate shareInstance];
    ctr.animationStyle = style;
    ctr.modalPresentationStyle = UIModalPresentationCustom;
    ctr.transitioningDelegate = self.transtionDelegate;
    [self presentViewController:ctr animated:YES completion:completion];
}
-(void)klDismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion{
//   KLTranstionDelegate *transtionDelegate = self.transitioningDelegate;

    [self dismissViewControllerAnimated:animated completion:completion];
}
#pragma mark - getter
-(void)setTranstionDelegate:(KLTranstionDelegate *)transtionDelegate{
    objc_setAssociatedObject(self, klTransitionDelegateKey, transtionDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(KLTranstionDelegate *)transtionDelegate{
    return objc_getAssociatedObject(self, klTransitionDelegateKey);
}
-(void)setAnimationStyle:(KLTranstionStyle)animationStyle{
    objc_setAssociatedObject(self, klAnimationStyleKey, @(animationStyle), OBJC_ASSOCIATION_ASSIGN);
}
-(KLTranstionStyle)animationStyle{
    return [objc_getAssociatedObject(self, klAnimationStyleKey) integerValue];
}
@end
