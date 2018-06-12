//
//  UIView+KLLayer.h
//  asdvlba
//
//  Created by zhaokaile on 2018/5/31.
//  Copyright © 2018年 zhaosi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KLLayer)

@property(nonatomic,assign)CGFloat kl_x;
@property(nonatomic,assign)CGFloat kl_y;
@property(nonatomic,assign)CGFloat kl_width;
@property(nonatomic,assign)CGFloat kl_height;
@property(nonatomic,assign)CGSize  kl_size;
@property(nonatomic,assign)CGPoint kl_point;
/**
 中心点需要在view的size之后使用
 */
@property(nonatomic,assign)CGPoint kl_center;
@property(nonatomic,assign)CGFloat kl_centerX;
@property(nonatomic,assign)CGFloat kl_centerY;

@property(nonatomic,assign,readonly)CGFloat kl_maxX;
@property(nonatomic,assign,readonly)CGFloat kl_maxY;

#pragma mark - 边框 、 描边
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
