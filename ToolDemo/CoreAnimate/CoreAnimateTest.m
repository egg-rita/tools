//
//  CoreAnimateTest.m
//  ToolDemo
//
//  Created by PC-013 on 2018/10/29.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "CoreAnimateTest.h"

@implementation CoreAnimateTest
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
-(void)animationTest3{
    CAShapeLayer *layer=  [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 100, self.bounds.size.width, 100);
    layer.path = [self path].CGPath;//path.CGPath;
    layer.lineWidth = 2;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    
    CABasicAnimation *strokeEnd =[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEnd.fromValue = @(0);
    strokeEnd.toValue = @(1);
    strokeEnd.duration = 5;
    strokeEnd.beginTime = 0.0;
    
    
    //放大
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(1);
    scaleAnimation.toValue = @(1.1);
    scaleAnimation.duration = 0.2;
    scaleAnimation.beginTime = 5.0;
    scaleAnimation.autoreverses = YES;
    
    
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStart.fromValue = @(0);
    strokeStart.toValue = @(1);
    strokeStart.duration = 5;
    strokeStart.beginTime = 5.5;
    
    
    
    groupAnimation.animations = @[strokeEnd,scaleAnimation,strokeStart];
    groupAnimation.duration = 10.5;
    groupAnimation.repeatCount = MAXFLOAT;
    [layer addAnimation:groupAnimation forKey:@"groupKey"];
    
    
    [self animationTest1];
}
-(void)animationTest2{
    CAShapeLayer *bglayer = [CAShapeLayer layer];
    //    bglayer.frame = CGRectMake(0, 100, self.view.kl_width, 100);
    bglayer.backgroundColor = [UIColor blackColor].CGColor;
    bglayer.path = [self path].CGPath;
    bglayer.borderColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:bglayer];
    
    CAShapeLayer *l1 = [CAShapeLayer layer];
    l1.backgroundColor = [UIColor redColor].CGColor;
    l1.frame = CGRectMake(0,0,1,1);
    [bglayer addSublayer:l1];
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    // 设置动画属性
    anim.keyPath =@"position";
    
    anim.path = [self path].CGPath;//path.CGPath;
    anim.duration =5;
    // 取消反弹
    anim.removedOnCompletion =NO;
    //动画是否回到原位
    [anim setAutoreverses:YES];
    anim.fillMode =kCAFillModeForwards;
    anim.repeatCount =MAXFLOAT;
    [l1 addAnimation:anim forKey:@""];
}

-(void)maskLayerTest{
    UIImage *maskImg = [UIImage imageNamed:@"KLImage.bundle/18.jpg"];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.layer.bounds;
    maskLayer.contents = (__bridge id)maskImg.CGImage;
    maskLayer.minificationFilter = kCAFilterTrilinear;
    [self.layer addSublayer:maskLayer];
//    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.layer.bounds];
//    imgView.layer.mask = maskLayer;
//    [self addSubview:imgView];
}
-(void)animationTest1{
    CGRect rect = CGRectMake(0, (self.bounds.size.height-100)*0.5, self.bounds.size.width, 100);
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.frame = rect;
    
    layer.path = [self path].CGPath;
    layer.lineWidth = 2;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.opacity = 0.5;
    [self.layer addSublayer:layer];
    
    //red line
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame         = CGRectMake(0, 0, 1, 1);//CGRectMake(0, 0, 600, 300);
    shapeLayer.path          = [self path].CGPath;
    shapeLayer.strokeEnd     = 0.f;
    
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor   = [UIColor redColor].CGColor;
    shapeLayer.lineWidth     = 2.f;
    shapeLayer.shadowColor   = [UIColor redColor].CGColor;
    shapeLayer.shadowOpacity = 1.f;
    shapeLayer.shadowRadius  = 4.f;
    shapeLayer.lineCap       = kCALineCapRound;
    [layer addSublayer:shapeLayer];
    
    
    CGFloat MAX = 0.98f;
    CGFloat GAP = 0.02;
    
    CABasicAnimation *aniStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    aniStart.fromValue         = [NSNumber numberWithFloat:0.f];
    aniStart.toValue           = [NSNumber numberWithFloat:MAX];
    
    CABasicAnimation *aniEnd   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    aniEnd.fromValue           = [NSNumber numberWithFloat:0.f + GAP];
    aniEnd.toValue             = [NSNumber numberWithFloat:MAX + GAP];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration          = 4.f;
    group.repeatCount       = CGFLOAT_MAX;
    group.autoreverses      = YES;
    group.animations        = @[aniEnd, aniStart];
    
    [shapeLayer addAnimation:group forKey:nil];
    
}
-(UIBezierPath*)path{
    CGRect rect = CGRectMake(0, (self.bounds.size.height-100)*0.5, self.bounds.size.width, 100);
    // 间距
    CGFloat padding = 4.0;
    // 半径(小圆半径)
    CGFloat curveRadius = (rect.size.height - 2 * padding)/3;
    
    //画心
    UIBezierPath *startPath = [UIBezierPath bezierPath];
    [startPath moveToPoint:CGPointMake(0, rect.size.height-padding)];
    [startPath addLineToPoint:CGPointMake(rect.size.width*0.5, rect.size.height-padding)];
    
    
    // 贝塞尔曲线
    UIBezierPath *heartPath = [UIBezierPath bezierPath];
    // 起点(圆的第一个点)
    CGPoint tipLocation = CGPointMake(rect.size.width/2, rect.size.height-padding);
    // 从起点开始画
    [heartPath moveToPoint:tipLocation];
    // (左圆的第二个点)
    CGPoint topLeftCurveStart = CGPointMake(rect.size.width/3 /*padding*/, rect.size.height/2.4);
    // 添加二次曲线
    [heartPath addQuadCurveToPoint:topLeftCurveStart controlPoint:CGPointMake(topLeftCurveStart.x, topLeftCurveStart.y + curveRadius)];
    // 画圆
    [heartPath addArcWithCenter:CGPointMake(topLeftCurveStart.x+curveRadius, topLeftCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    // (右圆的第二个点)
    CGPoint topRightCurveStart = CGPointMake(topLeftCurveStart.x + 2*curveRadius, topLeftCurveStart.y);
    // 画圆
    [heartPath addArcWithCenter:CGPointMake(topRightCurveStart.x+curveRadius, topRightCurveStart.y) radius:curveRadius startAngle:M_PI endAngle:0 clockwise:YES];
    // 右上角控制点
    CGPoint topRightCurveEnd = CGPointMake(topLeftCurveStart.x + 4*curveRadius, topRightCurveStart.y);
    // 添加二次曲线
    [heartPath addQuadCurveToPoint:tipLocation controlPoint:CGPointMake(topRightCurveEnd.x, topRightCurveEnd.y+curveRadius)];
    
    UIBezierPath *endPath = [UIBezierPath bezierPath];
    [endPath moveToPoint:CGPointMake(rect.size.width*0.5, rect.size.height-padding)];
    [endPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height-padding)];
    
    
    [startPath appendPath:heartPath];
    [startPath appendPath:endPath];
    
    return startPath;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
