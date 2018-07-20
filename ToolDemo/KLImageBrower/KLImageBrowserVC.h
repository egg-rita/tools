//
//  KLImageBrowerVC.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLImageBrowserUtilities.h"
#import "KLImageBrowserModel.h"
#import "KLImageBrowserScreenOrientationProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@class KLImageBrowserVC;
#pragma mark -
@protocol KLImageBrowserDelegate <NSObject>
@optional
/**
 图片浏览器翻页
 
 @param imageBrowser 当前图片浏览器
 @param index 目前的下标
 */
- (void)yBImageBrowser:(KLImageBrowserVC *)imageBrowser didScrollToIndex:(NSInteger)index;

/**
 点击功能栏的回调
 
 @param imageBrowser 当前图片浏览器
 @param functionModel 功能的数据model
 @param imageModel 当前页的图片模型
 */
//- (void)yBImageBrowser:(KLImageBrowserVC *)imageBrowser clickFunctionWithModel:(KLImageBrowserFunctionModel *)functionModel imageModel:(YBImageBrowserModel *)imageModel;
@end

#pragma mark 数据源代理 (dataSource agency)
@protocol KLImageBrowserDataSource <NSObject>
@required

/**
 返回点击的那个 UIImageView（用于做 YBImageBrowserAnimationMove 类型动效）
 
 @param imageBrowser 当前图片浏览器
 @return 点击的图片视图
 */
- (UIImageView * _Nullable)imageViewOfTouchForImageBrowser:(KLImageBrowserVC *)imageBrowser;

/**
 配置图片的数量
 
 @param imageBrowser 当前图片浏览器
 @return 图片数量
 */
- (NSInteger)numberInYBImageBrowser:(KLImageBrowserVC *)imageBrowser;

/**
 返回当前 index 图片对应的数据模型
 
 @param imageBrowser 当前图片浏览器
 @param index 当前下标
 @return 数据模型
 */
- (KLImageBrowserModel *)yBImageBrowser:(KLImageBrowserVC *)imageBrowser modelForCellAtIndex:(NSInteger)index;
@end

@interface KLImageBrowserVC : UIViewController<KLImageBrowserScreenOrientationProtocol>
@property (nonatomic,copy) NSArray<KLImageBrowserModel*> *dataArray;

@property (nonatomic,weak) id <KLImageBrowserScreenOrientationProtocol> dataSource;

-(void)show;
- (void)showFromController:(UIViewController *)controller;

/**
 当前下标
 */
@property (nonatomic, assign) NSUInteger currentIndex;

/**
 隐藏
 */
- (void)hide;

@property (nonatomic, weak) id <KLImageBrowserDelegate> delegate;


#pragma mark 功能栏操作

#pragma mark 动画相关
/**
 转场动画持续时间
 */
@property (nonatomic, assign) NSTimeInterval transitionDuration;

/**
 取消拖拽图片的动画效果
 */
@property (nonatomic, assign) BOOL cancelDragImageViewAnimation;

/**
 拖拽图片动效触发出场的比例（拖动距离/屏幕高度 默认0.15）
 */
@property (nonatomic, assign) CGFloat outScaleOfDragImageViewAnimation;

/**
 入场动画类型
 */
@property (nonatomic, assign) KLImageBrowserAnimation inAnimation;

/**
 出场动画类型
 */
@property (nonatomic, assign) KLImageBrowserAnimation outAnimation;

/**
 页与页之间的间距
 */
@property (nonatomic, assign) CGFloat distanceBetweenPages;


#pragma mark 屏幕方向相关
/**
 支持旋转的方向
 （请保证在 general -> deployment info -> Device Orientation 有对应的配置，目前不支持强制旋转）
 */
@property (nonatomic, assign) UIInterfaceOrientationMask kl_supportedInterfaceOrientations;

#pragma mark 缩放相关
/**
 是否需要自动计算缩放
 （默认是自动的，若改为NO，可用 YBImageBrowserModel 的 maximumZoomScale 设置希望当前图片的最大缩放比例）
 */
@property (nonatomic, assign) BOOL autoCountMaximumZoomScale;

/**
 纵屏时候图片填充类型
 */
@property (nonatomic, assign) KLImageBrowserImageViewFillType verticalScreenImageViewFillType;

/**
 横屏时候图片填充类型
 */
@property (nonatomic, assign) KLImageBrowserImageViewFillType horizontalScreenImageViewFillType;

#pragma mark 性能和内存相关
/**
 网络图片下载和持久化时，是否做内存缓存，为YES能提高图片第二次显示的性能，为NO能减少图片的内存占用（高清大图请置NO）
 */
@property (nonatomic, assign) BOOL downloaderShouldDecompressImages;
/**
 最大显示pt(超过这个数量框架乎自动做压缩和裁剪，默认是3500)
 */
@property (class, assign) CGFloat maxDisplaySize;


#pragma mark 其他

/**
 显示状态栏
 */
@property (class, assign) BOOL showStatusBar;

/**
 进入图片浏览器之前状态栏是否隐藏（进入框架内部会判断，若在图片浏览器生命周期之间外部的状态栏显示与否发生改变，你需要改变该属性的值）
 */
@property (class, assign) BOOL statusBarIsHideBefore;

/**
 状态栏是否是控制器优先
 */
@property (class, assign, readonly) BOOL isControllerPreferredForStatusBar;
NS_ASSUME_NONNULL_END
@end
