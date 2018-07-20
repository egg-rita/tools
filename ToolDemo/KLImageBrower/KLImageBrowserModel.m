//
//  KLImageBrowserModel.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLImageBrowserModel.h"
#import "KLImageBrowserDownloader.h"
#import "KLImageBrowserUtilities.h"
#import <UIImage+GIF.h>
#define KL_READIMAGE_FROMFILE(fileName, fileType) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:fileType]]

NSString * const KLImageBrowserModel_KVCKey_isLoading = @"isLoading";
NSString * const KLImageBrowserModel_KVCKey_isLoadFailed = @"isLoadFailed";
NSString * const KLImageBrowserModel_KVCKey_largeImage = @"largeImage";
char * const KLImageBrowserModel_SELName_download = "downloadImageProgress:success:failed:";
char * const KLImageBrowserModel_SELName_scaleImage = "scaleImageWithCurrentImageFrame:complete:";
char * const KLImageBrowserModel_SELName_cutImage = "cutImageWithTargetRect:complete:";

@interface KLImageBrowserModel ()
{
    BOOL _isLoading;
    BOOL _isLoadFailed;
    BOOL _isLoadSuccess;
    __weak id downloadToken;
    UIImage *_largeImage;
    KLImageBrowserModelDownloadProgressBlock progressBlock;
    KLImageBrowserModelDownloadSuccessBlock successBlock;
    KLImageBrowserModelDownloadFailedBlock failedBlock;
}
@end

@implementation KLImageBrowserModel
#pragma mark - public
-(void)setImageWithFileName:(NSString *)fileName fileType:(NSString *)type{
    self.image = KL_READIMAGE_FROMFILE(fileName, type);
}
-(void)setURLWithDownloadInAdvance:(NSURL *)url{
    [self downloadImageProgress:nil success:nil failed:nil];
}
#pragma mark - download
-(void)downloadImageProgress:(KLImageBrowserModelDownloadProgressBlock)progress
                     success:(KLImageBrowserModelDownloadSuccessBlock)success
                      failed:(KLImageBrowserModelDownloadFailedBlock)failed{
    KLImageBrowserModel *model = self;
    if (!model.url || _isLoadSuccess) {return;}
    
    progressBlock = progress;
    successBlock = success;
    failedBlock = failed;
    
    if (_isLoading) {return;}//仍然处理回调转接(预下载正式下载可能会同时请求)
    
    _isLoading = YES;
    
    downloadToken = [KLImageBrowserDownloader downloadWebImageWithURL:model.url progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (self->progressBlock) {
            self->progressBlock(model,receivedSize,expectedSize,targetURL);
        }
    } success:^(UIImage * _Nullable image, NSData * _Nullable data, BOOL finished) {
        _isLoading = NO;
        _isLoadFailed = NO;
        _isLoadSuccess = YES;
        //缓存处理
        if ([KLImageBrowserUtilities isGif:data]) {
            self.gifName = [UIImage sd_animatedGIFWithData:data];
        }
        else{
            model.image = image;
        }
        ///该判断是为了防止图片加载框架的BUG影响内部逻辑
        if (!model.image) {
            _isLoading = NO;
            _isLoadFailed = YES;
            if (self->failedBlock) {
                self->failedBlock(model,nil,finished);
            }
        }
        
        [KLImageBrowserDownloader storeImageDataWithKey:model.url.absoluteString image:image data:data];
        
        if (self->successBlock) {
            self->successBlock(model,image,data,finished);
        }
        
        
    } failed:^(NSError * _Nullable error, BOOL finished) {
        _isLoading = NO;
        _isLoadFailed = NO;
        if (self->failedBlock) {
            self->failedBlock(model,error,finished);
        }
    }];
}
//压缩图片
-(void)scaleImageWithCurrentImageFrame:(CGRect)imageFrame complete:(KLImageBrowserModelScaleImageSuccessBlock)complete{
    KLImageBrowserModel *model = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        model.image = [KLImageBrowserUtilities scaleToSizeWithImage:_largeImage size:imageFrame.size];
        if (complete) {
            KL_MAINTHREAD_ASYNC(^{
                complete(model);
            })
        }
    });
}
-(void)cutImageWhthTargetRect:(CGRect)targetRect complete:(KLImageBrowserModelCutImageSuccessBlock)complete{
    KLImageBrowserModel *model = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *resultImage = [KLImageBrowserUtilities cutToRectWithImage:_largeImage rect:targetRect];
        if (complete) {
            KL_MAINTHREAD_ASYNC(^{
                complete(model,resultImage);
            })
        }
    });
}

#pragma mark - setter
-(instancetype)init{
    if (self = [super init]) {
        _isLoading = NO;
        _isLoadFailed = NO;
        _isLoadSuccess = NO;
        _maximumZoomScale = 2;
    }
    return self;
}
-(void)setImage:(UIImage *)image{
    if (image.size.width||image.size.height) {
        _largeImage = image;
    }else{
        _image = image;
    }
}
-(void)setGifName:(NSString *)gifName{
    if (!gifName) {return;}
    _gifName = gifName;
    NSString *filePath =[[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"];
    if (!filePath) {return;}
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (!data) {return;}
    _gifName = [UIImage sd_animatedGIFWithData:data];
}
-(void)dealloc{
    if (downloadToken) {
        [KLImageBrowserDownloader cancelTaskWithDownloadToken:downloadToken];
    }
}
@end
