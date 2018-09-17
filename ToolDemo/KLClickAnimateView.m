//
//  KLClickAnimateView.m
//  ToolDemo
//
//  Created by PC-013 on 2018/8/20.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLClickAnimateView.h"

@implementation KLClickAnimateView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *aTouch = [touches anyObject];
    CGPoint aPoint = [aTouch locationInView:self];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(aPoint.x-15, aPoint.y-15, 30, 30);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.opacity = 1.0;
    layer.cornerRadius = 15.f;
    [self.layer addSublayer:layer];
    CABasicAnimation *baseAnimate = [CABasicAnimation animationWithKeyPath:@"bounds"];
    baseAnimate.duration = 0.5;
    baseAnimate.fromValue = @0;
    baseAnimate.toValue = @1.0;
    [layer addAnimation:baseAnimate forKey:@"bounds"];
//    [UIView animateWithDuration:3 animations:^{
//        layer.opacity = 0.2;
//        CGRect aRect = layer.frame;
//        aRect.size = CGSizeMake(60, 60);
//        layer.frame = aRect;
//
//    } completion:^(BOOL finished) {
//
//    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
