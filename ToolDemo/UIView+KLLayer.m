//
//  UIView+KLLayer.m
//  asdvlba
//
//  Created by zhaokaile on 2018/5/31.
//  Copyright © 2018年 zhaosi. All rights reserved.
//

#import "UIView+KLLayer.h"

@implementation UIView (KLLayer)
#pragma mark -
-(void)setKl_x:(CGFloat)kl_x{
    CGRect rect = self.frame;
    rect.origin.x = kl_x;
    self.frame = rect;
}
-(CGFloat)kl_x{
    return self.frame.origin.x;
}

-(void)setKl_y:(CGFloat)kl_y{
    CGRect rect = self.frame;
    rect.origin.y = kl_y;
    self.frame = rect;
}
-(CGFloat)kl_y{
    return self.frame.origin.y;
}

-(void)setKl_width:(CGFloat)kl_width{
    CGRect rect = self.frame;
    rect.size.width = kl_width;
    self.frame = rect;
}
-(CGFloat)kl_width{
    return self.frame.size.width;
}

-(void)setKl_height:(CGFloat)kl_height{
    CGRect rect = self.frame;
    rect.size.height = kl_height;
    self.frame = rect;
}
-(CGFloat)kl_height{
    return self.frame.size.height;
}

-(void)setKl_point:(CGPoint)kl_point{
    CGRect rect = self.frame;
    rect.origin = kl_point;
    self.frame = rect;
}
-(CGPoint)kl_point{
    CGRect rect = self.frame;
    return rect.origin;
}
-(void)setKl_size:(CGSize)kl_size{
    CGRect rect = self.frame;
    rect.size = kl_size;
    self.frame = rect;
}
-(CGSize)kl_size{
    CGRect rect = self.frame;
    return rect.size;
}
-(void)setKl_centerX:(CGFloat)kl_centerX{
    CGPoint center = self.center;
    center.x = kl_centerX;
    self.center = center;
}
-(CGFloat)kl_centerX{
    return CGRectGetMidX(self.frame);
}
-(void)setKl_centerY:(CGFloat)kl_centerY{
    CGPoint center = self.center;
    center.y = kl_centerY;
    self.center = center;
}
-(CGFloat)kl_centerY{
    return CGRectGetMidY(self.frame);
}

-(void)setKl_center:(CGPoint)kl_center{
    self.center = kl_center;
}
-(CGPoint)kl_center{
    return self.center;
}

-(CGFloat)kl_maxX{
   return CGRectGetMaxX(self.frame);
}
-(CGFloat)kl_maxY{
    return CGRectGetMaxY(self.frame);
}


#pragma mark - 边框、描边

-(void)kl_systemCornerRadius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth andLineColor:(UIColor*)color{
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = lineWidth;
    self.layer.borderColor = color.CGColor;
}

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
                      andopacity:(CGFloat)opacity{
    
    self.layer.shadowOffset = offsize;//偏移
    self.layer.shadowRadius = radius;//半径
    self.layer.shadowColor = color.CGColor;//颜色
    self.layer.shadowOpacity = opacity;//不透明度
}
/**
 裁边+描边
 */
-(void)kl_cornerRadiusWithRadius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth andLineColor:(UIColor*)color{
    
    //裁边
    [self kl_cuttingWithRadius:radius];
    //描边
    [self kl_borderWithRadius:radius andLineWidth:lineWidth*2 andStrokeColor:color];
    
}
//描边、边框
-(void)kl_borderWithRadius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth andStrokeColor:(UIColor*)strokeColor{

    [self.layer addSublayer:[self kl_borderLayerWithRadius:radius andLineWidth:lineWidth andStrokeColor:strokeColor]];
}
-(CAShapeLayer*)kl_borderLayerWithRadius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth andStrokeColor:(UIColor*)strokeColor{
    UIBezierPath * borderPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = borderPath.CGPath;
    borderLayer.lineWidth = lineWidth;
    borderLayer.strokeColor = strokeColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    return borderLayer;
}
//裁边
-(void)kl_cuttingWithRadius:(CGFloat)radius{
    //裁边
    self.layer.mask = [self kl_cuttLayerWithRadius:radius];
}

-(CAShapeLayer*)kl_cuttLayerWithRadius:(CGFloat)radius{
    //裁边
    UIBezierPath *cuttPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    
    CAShapeLayer *cuttLayer = [CAShapeLayer layer];
    cuttLayer.path = cuttPath.CGPath;
    cuttLayer.strokeColor = [UIColor clearColor].CGColor;
    return cuttLayer;
}



#pragma mark - 毛玻璃
-(void)kl_galssEffectWithStyle:(UIBlurEffectStyle)style{
    UIVisualEffectView *effectView = [self kl_glassEffectWithStyle:style andRect:self.bounds];
    [self addSubview:effectView];
}

-(UIVisualEffectView*)kl_glassEffectWithStyle:(UIBlurEffectStyle)style andRect:(CGRect)rect{
    /*
    UIBlurEffectStyleExtraLight,
    UIBlurEffectStyleLight,
    UIBlurEffectStyleDark,
    */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.frame = rect;
    return effectView;
}


@end
