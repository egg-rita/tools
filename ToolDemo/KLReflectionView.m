//
//  KLReflectionView.m
//  ToolDemo
//
//  Created by PC-013 on 2018/8/23.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLReflectionView.h"

@implementation KLReflectionView

+ (Class)layerClass{
    return [CAReplicatorLayer class];
}

-(instancetype)init{
    if (self = [super init]) {
        [self confingUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self confingUI];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
}
-(void)confingUI{
    CAReplicatorLayer * replayer = (CAReplicatorLayer*)self.layer;
    
    replayer.instanceCount = 2;
    
    CGFloat offsetHeight = self.bounds.size.height+_padding;
    //    设置重复层的transform
    CATransform3D transform = CATransform3DIdentity;
    
    //    设置沿着Y轴位移
    transform = CATransform3DTranslate(transform, 0, offsetHeight, 0);
    
    //    设置Y方向缩放-1，
//    transform = CATransform3DScale(transform, 1, -1, 1);
    
    //沿X轴旋转 180°
    transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);
    
    replayer.instanceTransform = transform;
    

//    replayer.instanceRedOffset -= 0.5;
//    replayer.instanceGreenOffset -= 0.5;
//    replayer.instanceBlueOffset -= 0.5;
    replayer.instanceAlphaOffset -= 0.5;
}
-(void)drawRect:(CGRect)rect{
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self confingUI];
}












/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
