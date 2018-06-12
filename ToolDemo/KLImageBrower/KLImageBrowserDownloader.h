//
//  KLImageBrowserDownloader.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <SDWebImage/SDWebImageDownloader.h>
@class SDWebImageDownloadToken;
NS_ASSUME_NONNULL_BEGIN

typedef void(^KLImageBrowserDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL);
typedef void(^KLImageBrowserDownloaderSuccessBlock)(UIImage * _Nullable image, NSData * _Nullable data, BOOL finished);
typedef void(^KLImageBrowserDownloaderFailedBlock)(NSError * _Nullable error, BOOL finished);
typedef void(^KLImageBrowserDownloaderCacheQueryCompletedBlock)(UIImage * _Nullable image, NSData * _Nullable data);

@interface KLImageBrowserDownloader : NSObject
+(SDWebImageDownloadToken*)downloadWebImageWithURL:(NSURL*)url
                    progress:(KLImageBrowserDownloaderProgressBlock)progress
                     success:(KLImageBrowserDownloaderSuccessBlock)success
                      failed:(KLImageBrowserDownloaderFailedBlock)failed;
//取消某个下载任务
+(void)cancelTaskWithDownloadToken:(SDWebImageDownloadToken*)token;

//缓存
+(void)storeImageDataWithKey:(NSString*)key image:(UIImage* _Nullable)image data:(NSData* _Nullable)data;
//判断缓存中 imageData 是否存在(采用 block, 不管替换框架是异步还是同步都行)
+(void)memeryImageDataExistWithKey:(NSString*)key exist:(void(^)(BOOL exist))exist;
//查找缓存(采用block 不管替换框架是异步还是同步都行)
+(void)queryCacheOperationForKey:(NSString*)key completed:(KLImageBrowserDownloaderCacheQueryCompletedBlock)completed;


/**
 //框架下载时候的图片解压(下载和缓存的映像解压缩可以提高性能，但会消耗大量内存。
 //默认值为YES。如果由于内存消耗过多而导致崩溃，则将其设置为NO。)
 */
+(void)shouldDecompressImages:(BOOL)should;
@end
NS_ASSUME_NONNULL_END
