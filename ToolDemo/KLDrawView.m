//
//  DrawView.m
//  Quartz2DDemo
//
//  Created by zhaokaile on 2018/6/5.
//  Copyright © 2018年 zhaokaile. All rights reserved.
//

#import "KLDrawView.h"

@implementation PathModel

@end

#pragma mark ---
@interface KLDrawView(){
    CGMutablePathRef _currentPath;
}

@end
@implementation KLDrawView
-(instancetype)init{
    if (self =[super init]) {
        _linemode =  kCGBlendModeNormal;
        _linecolor = [UIColor blackColor];
        _linewidth = 1.0;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
   CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (PathModel *model in self.pathArr) {
        CGContextSetStrokeColorWithColor(ctx, model.linecolor.CGColor);
        CGContextSetLineWidth(ctx, model.lineWidth);
        CGContextSetBlendMode(ctx, model.lineMode);
        CGContextBeginPath(ctx);
        CGContextAddPath(ctx, model.path);
        CGContextStrokePath(ctx);
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:self];
    _currentPath = CGPathCreateMutable();
    
    //创建模型
    PathModel *model = [[PathModel alloc]init];
    model.path = _currentPath;
    model.lineMode = _linemode;
    model.lineWidth = _linewidth;
    model.linecolor = _linecolor;
    [self.pathArr addObject:model];
    CGPathMoveToPoint(_currentPath, NULL, startPoint.x, startPoint.y);
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    CGPathAddLineToPoint(_currentPath, NULL, movePoint.x, movePoint.y);
//    NSLog(@"%@",[NSValue valueWithCGPoint:movePoint]);
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.isDraw = NO;
    if (self.DrawBlock) {
        self.DrawBlock();
    }
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (CGRectContainsPoint(self.bounds, point)) {
        self.isDraw = YES;
        if (self.DrawBlock) {
            self.DrawBlock();
        }
    }
    return self;
}
//清屏
-(void)clearDrawBoard{
    if (self.pathArr.count > 0) {
        [self.pathArr removeAllObjects];
        [self setNeedsDisplay];
    }
}
//回退
-(void)goBack{
    if (self.pathArr.count > 0) {
        [self.pathArr removeLastObject];
        [self setNeedsDisplay];
    }
}
-(void)GetImage:(GetImageBlock)block{

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 截取画板尺寸
    CGImageRef sourceImageRef = [newImg CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // 截图保存相册
//    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    
    if (block) {
        block(newImage);
    }
}
#pragma mark - getter
-(NSMutableArray *)pathArr{
    if (!_pathArr) {
        _pathArr = [NSMutableArray array];
    }
    return _pathArr;
}
@end
