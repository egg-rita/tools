//
//  UIViewController+KLTranstion.h
//  ToolDemo
//
//  Created by PC-013 on 2018/10/11.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLTranstionStyle.h"
@interface UIViewController (KLTranstion)
@property(nonatomic,assign)KLTranstionStyle animationStyle;

-(void)klPresentViewController:(UIViewController*)ctr transtionStyle:(KLTranstionStyle)style completion:(void(^)(void))completion;

-(void)klDismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
@end
