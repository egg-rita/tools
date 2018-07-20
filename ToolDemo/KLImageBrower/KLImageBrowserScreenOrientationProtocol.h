//
//  KLImageBrowserScreenOrientationProtocol.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/18.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLImageBrowserUtilities.h"
@protocol KLImageBrowserScreenOrientationProtocol <NSObject>
/**
 当前视图UI适配的屏幕方向
 */
@property (nonatomic, assign) KLImageBrowserScreenOrientation KL_screenOrientation;

/**
 当前视图在竖直屏幕的frame
 */
@property (nonatomic, assign) CGRect KL_frameOfVertical;

/**
 当前视图在横向屏幕的frame
 */
@property (nonatomic, assign) CGRect KL_frameOfHorizontal;

/**
 更新约束是否完成
 */
@property (nonatomic, assign) BOOL KL_isUpdateUICompletely;

- (void)so_setFrameInfoWithSuperViewScreenOrientation:(KLImageBrowserScreenOrientation)screenOrientation superViewSize:(CGSize)size;

- (void)so_updateFrameWithScreenOrientation:(KLImageBrowserScreenOrientation)screenOrientation;



@end
