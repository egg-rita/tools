//
//  UIView+KLLayer.h
//  asdvlba
//
//  Created by zhaokaile on 2018/5/31.
//  Copyright © 2018年 zhaosi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KLLayer)

/**
 系统画框的方法
 */
-(void)kl_systemCornerRadius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth andLineColor:(UIColor*)color;
/**
 阴影
 @param offsize
 @param radius
 @param color
 @param opacity [0,1]
 */
-(void)kl_systemShadowWithOffset:(CGSize)offsize
                       andRadius:(CGFloat)radius
                        andColor:(UIColor*)color
                      andopacity:(CGFloat)opacity;
/**
    裁边+边框
 @param radius 圆角半径
 @param lineWidth 线宽
 @param color 描边的颜色
 */
-(void)kl_cornerRadiusWithRadius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth andLineColor:(UIColor*)color;

//裁边、
-(void)kl_cuttingWithRadius:(CGFloat)radius;
-(CAShapeLayer*)kl_cuttLayerWithRadius:(CGFloat)radius;

//描边、边框
-(void)kl_borderWithRadius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth andStrokeColor:(UIColor*)strokeColor;
-(CAShapeLayer*)kl_borderLayerWithRadius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth andStrokeColor:(UIColor*)strokeColor;

#pragma mark - 毛玻璃
-(void)kl_galssEffectWithStyle:(UIBlurEffectStyle)style;

-(UIVisualEffectView*)kl_glassEffectWithStyle:(UIBlurEffectStyle)style andRect:(CGRect)rect;
@end
