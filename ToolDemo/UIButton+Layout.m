//
//  UIButton+Layout.m
//  ToolDemo
//
//  Created by 赵凯乐 on 2018/3/29.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "UIButton+Layout.h"

@implementation UIButton (Layout)
-(void)KL_LayoutButtonWithEdgeInsetsStyle:(KLButtonEdgeInsetsStyle)stype andSpace:(CGFloat)padding{
    padding = padding? padding : 0;
    
    /**
     *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
   
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    
    switch (stype) {
        case KLButtonEdgeInsetsStyleTop://image在上，label在下
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-padding/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-padding/2.0, 0);
        }
            break;
        case KLButtonEdgeInsetsStyleLeft://image在左，label在右
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -padding/2.0, 0, padding/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, padding/2.0, 0, -padding/2.0);
        }
            break;
        case KLButtonEdgeInsetsStyleBottom://image在下，label在上
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-padding/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-padding/2.0, -imageWith, 0, 0);
        }
            break;
        case KLButtonEdgeInsetsStyleRight://image在右，label在左
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+padding/2.0, 0, -labelWidth-padding/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-padding/2.0, 0, imageWith+padding/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
    
}
@end
