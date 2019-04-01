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

#pragma mark - 阴影

/**
 根据view的形状构建一个相应的阴影形状(方形)
 @param color 阴影的颜色
 @param opacity 阴影的透明度
 */
-(void)kl_customFastSquareShadowWithColor:(UIColor*)color andShadowOpacity:(float)opacity;
/**
 自定义路径阴影(自定义程度较高)
 @param color 阴影颜色
 @param opacity 阴影透明度(0~1.0)
 @param r 阴影的圆角半径
 @param radius 阴影的扩散半径
 */
-(void)kl_customSquareShadowWithColor:(UIColor*)color andShadowOpacity:(float)opacity andcornerRadius:(CGFloat)r andShadowRadius:(CGFloat)radius;


/**
 自定义阴影路径(基础方法)

 @param size <#size description#>
 @param path <#path description#>
 @param color <#color description#>
 @param opacity <#opacity description#>
 */
-(void)kl_customShadowWithSize:(CGSize)size
                       andPath:(UIBezierPath*)path
                andShadowColor:(UIColor*)color
              andShadowOpacity:(float)opacity;

#pragma mark - 毛玻璃
-(void)kl_galssEffectWithStyle:(UIBlurEffectStyle)style;

-(UIVisualEffectView*)kl_glassEffectWithStyle:(UIBlurEffectStyle)style andRect:(CGRect)rect;
@end
