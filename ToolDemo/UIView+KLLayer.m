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

#pragma mark - 阴影
-(void)kl_customFastSquareShadowWithColor:(UIColor*)color andShadowOpacity:(float)opacity{
    color = color == nil? [UIColor blackColor]:color;
    [self kl_customSquareShadowWithColor:color andShadowOpacity:opacity andcornerRadius:self.layer.cornerRadius andShadowRadius:3];
}
-(void)kl_customSquareShadowWithColor:(UIColor*)color andShadowOpacity:(float)opacity andcornerRadius:(CGFloat)r andShadowRadius:(CGFloat)radius{
    
    r = r<0? 0:r;
    color = color == nil? [UIColor blackColor]:color;
    radius = radius<0? 0:radius;
    CGSize size = self.bounds.size;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(-radius*0.5, -radius*0.5, size.width+radius  , size.height+radius) cornerRadius:r];
    [self kl_customShadowWithSize:CGSizeZero andPath:path andShadowColor:color andShadowOpacity:opacity];
}
-(void)kl_customShadowWithSize:(CGSize)size
                       andPath:(UIBezierPath*)path
                andShadowColor:(UIColor*)color
              andShadowOpacity:(float)opacity{
    self.layer.shadowOffset = size;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath = path.CGPath;
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
