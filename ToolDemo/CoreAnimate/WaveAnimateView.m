//
//  WaveAnimateView.m
//  ToolDemo
//
//  Created by PC-013 on 2018/11/19.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "WaveAnimateView.h"
@interface WaveAnimateView()
@property(nonatomic,assign)CGFloat viewWidth;//视图的宽度
@property(nonatomic,assign)CGFloat viewHeight;//视图的宽度

@property(nonatomic,strong)CADisplayLink *displayLink;

@property(nonatomic,strong)CAShapeLayer *shapeLayer;
@property(nonatomic,strong)UIBezierPath *path;

@property(nonatomic,strong)CAShapeLayer *shapeLayer2;
@property(nonatomic,strong)UIBezierPath *path2;

@end
@implementation WaveAnimateView
/**
 建议使用此方法初始化
 @param frame
 @return
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _A = 10.f;
        _k = 0;
        _w = 0.03;
        
        [self InitData];
    }
    return self;
}

-(void)InitData{
    _viewWidth = CGRectGetWidth(self.frame);
    _viewHeight = CGRectGetHeight(self.frame);
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 0, _viewWidth, _viewHeight);
    [self.layer addSublayer:_shapeLayer];
    
    _shapeLayer2 = [CAShapeLayer layer];
    _shapeLayer2.frame = CGRectMake(0, 0, _viewWidth, _viewHeight);
    [self.layer addSublayer:_shapeLayer2];
    
    
    _shapeLayer.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3].CGColor;
    _shapeLayer2.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.3].CGColor;

    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawPath)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)drawPath{
    static double i = 0;
//    CGFloat A = 10.f;//A振幅
//    CGFloat k = 0;//y轴偏移
//    CGFloat w = 0.03;////角速度ω变大，则波形在X轴上收缩（波形变紧密）；角速度ω变小，则波形在X轴上延展（波形变稀疏）。不等于0
    CGFloat φ = 0+i;////初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
    
    _path = [UIBezierPath bezierPath];
    _path2 = [UIBezierPath bezierPath];
    
    [_path moveToPoint:CGPointZero];
    [_path2 moveToPoint:CGPointZero];
    
   NSInteger count = _viewWidth+1;
    for (int i = 0; i<count; i++) {
        CGFloat x = i;
        CGFloat y = _A * sin(_w * x + φ)+_k;
        CGFloat y2 = _A * cos(_w * x + φ) + _k;
        [_path addLineToPoint:CGPointMake(x, y)];
        [_path2 addLineToPoint:CGPointMake(x, y2)];
    }
    
    [_path addLineToPoint:CGPointMake(_viewWidth, _viewHeight)];
    [_path addLineToPoint:CGPointMake(0, _viewHeight)];
    _path.lineWidth = 1;
    _shapeLayer.path = _path.CGPath;
    
    [_path2 addLineToPoint:CGPointMake(_viewWidth, _viewHeight)];
    [_path2 addLineToPoint:CGPointMake(0, _viewHeight)];
    _path2.lineWidth = 1;
    _shapeLayer2.path = _path2.CGPath;
    
    i+=0.1;
    if (i>M_PI*2) {
        i=0;//防止i越界
    }
    

}

#pragma mark - Setter
- (void)setA:(CGFloat)A{
    _A = A;
}
- (void)setK:(CGFloat)k{
    _k = k;
}
- (void)setW:(CGFloat)w{
    _w = w;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
