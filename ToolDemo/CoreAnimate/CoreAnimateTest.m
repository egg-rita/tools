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
        [self configUI];
    }
    return self;
}
-(void)configUI{
    

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,200, 300)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.center = self.center;
    view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"KLImage.bundle/14.jpg"].CGImage);
//    view.layer.anchorPoint = CGPointMake(1, 0.2) ;
    view.layer.contentsCenter = CGRectMake(0, 0, 0.5, 0.5);
//    view.layer.contentsGravity = kCAGravityCenter;

    [self addSubview:view];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
