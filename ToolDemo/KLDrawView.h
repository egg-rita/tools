//
//  DrawView.h
//  Quartz2DDemo
//
//  Created by zhaokaile on 2018/6/5.
//  Copyright © 2018年 zhaokaile. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PathModel:NSObject

@property(nonatomic)CGMutablePathRef path;
@property(nonatomic,assign)CGFloat lineWidth;
@property(nonatomic,assign)CGBlendMode lineMode;
@property(nonatomic,strong)UIColor *linecolor;
@end

typedef void(^GetImageBlock)(UIImage *image);
@interface KLDrawView : UIView

@property(nonatomic,assign)CGFloat linewidth;//线宽
@property(nonatomic,assign)UIColor *linecolor;//线条的颜色
@property(nonatomic,assign)CGBlendMode linemode;

@property(nonatomic,strong)NSMutableArray *pathArr;

@property(nonatomic,assign)BOOL isDraw;//是否在此视图上画画
@property(nonatomic,copy)void (^DrawBlock)();

//获取一张图片
-(void)GetImage:(GetImageBlock)block;
//清空画板
-(void)clearDrawBoard;
//回退一步
-(void)goBack;

@end
