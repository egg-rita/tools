//
//  UIButton+Layout.h
//  ToolDemo
//
//  Created by 赵凯乐 on 2018/3/29.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,KLButtonEdgeInsetsStyle){
    KLButtonEdgeInsetsStyleTop = 0,//image在上，label在下
    KLButtonEdgeInsetsStyleLeft = 1,//image在左，label在右
    KLButtonEdgeInsetsStyleRight = 2,//image在右，label在左
    KLButtonEdgeInsetsStyleBottom = 3,//image在下，label在上
};
@interface UIButton (Layout)

/**
 button 调整图片和文字的位置

 @param stype 类型
 @param padding 文字和图片之间的间距 默认是0
 */
-(void)KL_LayoutButtonWithEdgeInsetsStyle:(KLButtonEdgeInsetsStyle)stype andSpace:(CGFloat)padding;
@end
