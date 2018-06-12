//
//  KLImageBrowserModel.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIImage+GIF.h>
NS_ASSUME_NONNULL_BEGIN
@class KLImageBrowserModel;

typedef void(^KLImageBrowserModelDownloadProgressBlock)(KLImageBrowserModel *backModel, NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL);
typedef void(^KLImageBrowserModelDownloadSuccessBlock)(KLImageBrowserModel *backModel, UIImage * _Nullable image, NSData * _Nullable data, BOOL finished);
typedef void(^KLImageBrowserModelDownloadFailedBlock)(KLImageBrowserModel *backModel, NSError * _Nullable error, BOOL finished);
typedef void(^KLImageBrowserModelScaleImageSuccessBlock)(KLImageBrowserModel *backModel);
typedef void(^KLImageBrowserModelCutImageSuccessBlock)(KLImageBrowserModel *backModel, UIImage *targetImage);

FOUNDATION_EXTERN NSString * const KLImageBrowserModel_KVCKey_isLoading;
FOUNDATION_EXTERN NSString * const KLImageBrowserModel_KVCKey_isLoadFailed;
FOUNDATION_EXTERN NSString * const KLImageBrowserModel_KVCKey_largeImage;
FOUNDATION_EXTERN char * const KLImageBrowserModel_SELName_download;
FOUNDATION_EXTERN char * const KLImageBrowserModel_SELName_scaleImage;
FOUNDATION_EXPORT char * const KLImageBrowserModel_SELName_cutImage;




#pragma mark - KLImageBrowserModel
@interface KLImageBrowserModel : NSObject

/**
 本地图片
 （setImageWithFileName:fileType: 若图片不在 Assets 中，尽量使用此方法以避免图片缓存过多导致内存飙升
 */
@property (nonatomic, strong, nullable) UIImage *image;
-(void)setImageWithFileName:(NSString*)fileName fileType:(NSString*)type;

/**
 网络图片 url
 （setUrlWithDownloadInAdvance: 设置 url 的时候异步预下载）
 */
@property (nonatomic, strong, nullable) NSURL *url;
-(void)setURLWithDownloadInAdvance:(NSURL*)url;

/**
 本地GIF 名字
 */
@property (nonatomic, strong, nullable) NSString *gifName;

@property (nonatomic, strong, nullable) UIImage *gifImage;
/**
 来源图片视图
 (用于做 ImageBrowserAnimationMove 类型的动效)
 */
@property (nonatomic, strong, nullable) UIImageView *sourceImageView;

/**
 预览缩略图
 */
@property (nonatomic, strong, nullable) KLImageBrowserModel *previewModel;

/**
 最大缩放值 默认2
 （若 KLImageBrowser 的 autoCountMaximumZoomScale 属性为 NO 有效）
 */
@property (nonatomic, assign) CGFloat maximumZoomScale;

@end
NS_ASSUME_NONNULL_END
