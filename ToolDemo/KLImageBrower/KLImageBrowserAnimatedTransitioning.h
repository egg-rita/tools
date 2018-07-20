//
//  KLImageBrowserAnimatedTransitioning.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/18.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLImageBrowserUtilities.h"
#import "KLImageBrowserVC.h"
#import "KLImageBrowserView.h"
#import "KLImageBrowserCell.h"
@interface KLImageBrowserAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>
-(void)setInfoWithImageBrowser:(KLImageBrowserVC*)browser;
@end
