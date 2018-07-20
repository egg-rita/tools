//
//  KLImageBrowserDownloader.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLImageBrowserDownloader.h"
#import <SDWebImage/SDWebImageDownloader.h>
#import <SDWebImage/SDImageCache.h>
#import "KLImageBrowserUtilities.h"

static SDImageCache *_imageCache = nil;
static SDWebImageDownloader *_downloader = nil;


@interface KLImageBrowserDownloader()
@property (class, strong) SDImageCache *imageCache;
@property (class, strong) SDWebImageDownloader *downloader;
@end
@implementation KLImageBrowserDownloader
#pragma mark - public
+(SDWebImageDownloadToken*)downloadWebImageWithURL:(NSURL *)url
                    progress:(KLImageBrowserDownloaderProgressBlock)progress
                     success:(KLImageBrowserDownloaderSuccessBlock)success
                      failed:(KLImageBrowserDownloaderFailedBlock)failed{
    if (!url) {return nil;}
    SDWebImageDownloadToken *token = [self.downloader downloadImageWithURL:url options:(SDWebImageDownloaderLowPriority) progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (progress) {progress(receivedSize,expectedSize,targetURL);}
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (error) {
            if (failed) {
                failed(error,finished);
            }
            return ;
        }
        if (success) {success(image,data,finished);}
    }];
    return token;
}

+(void)cancelTaskWithDownloadToken:(SDWebImageDownloadToken*)token{
    if (token) {
        [self.downloader cancel:token];
    }
}

+(void)storeImageDataWithKey:(NSString *)key image:(UIImage *)image data:(NSData *)data{
    if (!image) {return;}
    BOOL isGif = [KLImageBrowserUtilities isGif:data];
    if(isGif && !data) {return;}
    [self.imageCache storeImage:image imageData:isGif?data:nil forKey:key toDisk:YES completion:nil];
}

+(void)memeryImageDataExistWithKey:(NSString *)key exist:(void (^)(BOOL))exist{
    if (exist) {
        exist([self.imageCache diskImageDataExistsWithKey:key]);
    }
}
+(void)queryCacheOperationForKey:(NSString *)key completed:(KLImageBrowserDownloaderCacheQueryCompletedBlock)completed{
    if (!key) {return;}
    [self.imageCache queryCacheOperationForKey:key
                                       options:(SDImageCacheQueryDataWhenInMemory|SDImageCacheQueryDiskSync)
                                          done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
                                              if (completed) {
                                                  completed(image,data);
                                              }
                                          }];
}
+(void)shouldDecompressImages:(BOOL)should{
    self.downloader.shouldDecompressImages = should;
    self.imageCache.config.shouldDecompressImages = should;
}
#pragma mark - getter && setter
+(SDWebImageDownloader*)downloader{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _downloader = [SDWebImageDownloader sharedDownloader];
        _downloader.shouldDecompressImages = YES;
    });
    return _downloader;
}
+(void)setDownloader:(SDWebImageDownloader*)downloader{
    if (!self.downloader) {
        _downloader = downloader;
    }
}
+(void)setImageCache:(SDImageCache *)imageCache{
    if (!self.imageCache) {
        _imageCache = imageCache;
    }
}
+(SDImageCache *)imageCache{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imageCache = [SDImageCache sharedImageCache];
    });
    return _imageCache;
}
@end
