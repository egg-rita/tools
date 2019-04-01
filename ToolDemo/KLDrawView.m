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
@property(nonatomic,strong)UIBezierPath *path1;
@property(nonatomic,strong)UIBezierPath *path2;
@end
@implementation KLDrawView

+ (void)load{
    //runtime加载类或分类的时候调用load方法，整个程序运行期间只调用一次
    NSLog(@"--load--");
}
+ (void)initialize
{
//类第一次接收到消息的时候调用，以后不会在调用，通过objc_sendMsg函数调用
    if (self == [self class]) {
        NSLog(@"--initialize--");
    }
}

-(instancetype)init{
    if (self =[super init]) {
        _linemode =  kCGBlendModeNormal;
        _linecolor = [UIColor blackColor];
        _linewidth = 1.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    /*
   CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (PathModel *model in self.pathArr) {
        CGContextSetStrokeColorWithColor(ctx, model.linecolor.CGColor);
        CGContextSetLineWidth(ctx, model.lineWidth);
        CGContextSetBlendMode(ctx, model.lineMode);
        CGContextBeginPath(ctx);
        CGContextAddPath(ctx, model.path);
        CGContextStrokePath(ctx);
    }
    */
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, self.linecolor.CGColor);
    CGContextSetLineWidth(ctx, self.linewidth);
    CGContextSetBlendMode(ctx, self.linemode);
    CGContextBeginPath(ctx);
    CGContextAddPath(ctx, self.path1.CGPath);
    CGContextStrokePath(ctx);
    
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

    
    
    //创建新路径
    self.path2 = [UIBezierPath bezierPath];
    [self.path2 moveToPoint:CGPointMake(startPoint.x, startPoint.y)];
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    
    //添加路径
    CGPathAddLineToPoint(_currentPath, NULL, movePoint.x, movePoint.y);
    
    //拼接路径
    [self.path2 addLineToPoint:CGPointMake( movePoint.x, movePoint.y)];
    [self.path1 appendPath:self.path2];
    
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.path2 removeAllPoints];
    self.path2 = nil;
    
    self.isDraw = NO;
    if (self.DrawBlock) {
        self.DrawBlock();
    }
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if ([self pointInside:point withEvent:event]) {
        if (CGRectContainsPoint(self.bounds, point)) {
            self.isDraw = YES;
            if (self.DrawBlock) {
                self.DrawBlock();
            }
        }
        return self;
    }else{
        return [super hitTest:point withEvent:event];
    }
}
//清屏
-(void)clearDrawBoard{
    if (self.pathArr.count > 0) {
        [self.pathArr removeAllObjects];
        self.path2 = nil;
        [self.path1 removeAllPoints];
        self.path1 = nil;
        [self setNeedsDisplay];
    }
}
//回退
-(void)goBack{
    if (self.pathArr.count > 0) {
        [self.pathArr removeLastObject];
        
        for (PathModel *model  in self.pathArr) {
            [self.path1 appendPath:[UIBezierPath bezierPathWithCGPath:CGPathCreateCopy(model.path)]];
        }

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
    
    if (block) {
        block(newImage);
    }
}
#pragma mark - getter
-(UIBezierPath *)path1{
    if (!_path1) {
        _path1 = [UIBezierPath bezierPath];
    }
    return _path1;
}
-(NSMutableArray *)pathArr{
    if (!_pathArr) {
        _pathArr = [NSMutableArray array];
    }
    return _pathArr;
}
@end
