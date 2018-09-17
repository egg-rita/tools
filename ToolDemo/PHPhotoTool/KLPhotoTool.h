//
//  KLPhotoTool.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/17.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PHAsset;
@class AVAsset;

typedef void(^AssetArrBlock)(NSMutableArray<PHAsset*> *assetArr);
typedef void(^AVAssetArrBlock)(NSMutableArray<AVAsset*> *avassetArr);

@interface KLPhotoTool : NSObject
//判断应用访问相册的权限
+(BOOL)KLPhotoPermissions;

#pragma mark - 保存照片到相册中

/**
 @param image 指定一张或多张图片
 */
+(void)KLSaveNewAssetWithImage:(UIImage*)image;//指定一张图片
+(void)KLSaveNewAssetWitnImageArr:(NSArray<UIImage*>*)imgArr;//指定多张图片
+(void)KLSaveNewPhototWithURLStr:(NSArray<NSString*>*)URLArr;//指定图片地址数组


#pragma mark - 保存视频到相册中
+(void)KLSaveNewVideoWithVideoPath:(NSArray<NSString*>*)videoPathArr WithAssetBlock:(AssetArrBlock)assetArr;
@end
