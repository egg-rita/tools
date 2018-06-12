//
//  KLImageBrowerVC.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLImageBrowserVC : UIViewController

/**
 最大显示pt(超过这个数量框架乎自动做压缩和裁剪，默认是3500)
 */
@property (class, assign) CGFloat maxDisplaySize;
@end
