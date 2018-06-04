//
//  KLAdvertView.h
//  LL_AdVertScrollView
//
//  Created by zhaokaile on 2018/5/25.
//  Copyright © 2018年 zhaosi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,ScrollType){
    ScrollType_bottom = 0,//从下往上滚
    ScrollType_top = 1 ,//从上往下滚
    ScrollType_left = 2 ,//从左往右滚
    ScrollType_right = 3//从右往左滚
};
@interface KLAdvertView : UIView
@property(nonatomic,copy)NSArray<NSString*> *dataSource;//数据源
@property(nonatomic,assign)ScrollType type;//滚动方向

-(instancetype)initWithFrame:(CGRect)frame andOneView:(UIView*)oneView andTwoView:(UIView*)twoView;
@end
