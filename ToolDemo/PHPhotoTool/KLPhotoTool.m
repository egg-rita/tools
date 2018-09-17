//
//  KLPhotoTool.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/17.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLPhotoTool.h"
#import <Photos/Photos.h>

/** NSAssert */
#if !defined(_NSAssertBody)
#define NSAssert(condition, desc, ...)    \
do {                \
__PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
if (!(condition)) {        \
NSString *__assert_file__ = [NSString stringWithUTF8String:__FILE__]; \
__assert_file__ = __assert_file__ ? __assert_file__ : @"<Unknown File>"; \
[[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd \
object:self file:__assert_file__ \
lineNumber:__LINE__ description:(desc), ##__VA_ARGS__]; \
}                \
__PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
} while(0)
#endif


static KLPhotoTool *_photoTool = nil;



@interface KLPhotoTool()

@end

@implementation KLPhotoTool
+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _photoTool = [[self alloc] init];
    });
    return _photoTool;
}
//判断应用访问相册的权限
+(BOOL)KLPhotoPermissions{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block BOOL result;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_semaphore_signal(semaphore);
        switch (status) {
            case PHAuthorizationStatusNotDetermined://尚未对该应用程序作出选择
            {
//                NSLog(@"尚未对该应用程序作出选择");
                result = NO;
            }
                break;
            case PHAuthorizationStatusRestricted://未被授权访问照片数据
            {
//                NSLog(@"未被授权访问照片数据");
                result = NO;
            }
                break;
            case PHAuthorizationStatusDenied://明确拒绝访问相册的权限
            {
//                NSLog(@"您已拒绝");
                result = NO;
            }
                break;
            case PHAuthorizationStatusAuthorized://有权限
            {
//                NSLog(@"有权限");
                result = YES;
            }
                break;
                
            default://其他
//                NSLog(@"其他");
                result = NO;
                break;
        }
    }];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.1*1000*1000*1000);
    dispatch_semaphore_wait(semaphore, time);
    
    return result;
}
#pragma mark - 保存照片到相册
+(void)KLSaveNewAssetWithImage:(UIImage*)image{
    if (image) {
        PHAssetCollection *album = [[PHAssetCollection alloc]init];
        [self KLAddNewAssetWithImageS:@[image] toAlbum:album];
    }
}
+(void)KLSaveNewAssetWitnImageArr:(NSArray<UIImage*>*)imgArr{
    if (imgArr.count > 0) {
        PHAssetCollection *album = [[PHAssetCollection alloc]init];
        [self KLAddNewAssetWithImageS:imgArr toAlbum:album];
    }
}

+ (void)KLAddNewAssetWithImage:(UIImage *)image toAlbum:(PHAssetCollection *)album {
    if (image && album) {
        [self KLAddNewAssetWithImageS:@[image] toAlbum:album];
    }
}

+ (void)KLAddNewAssetWithImageS:(NSArray<UIImage*>*)imgArr toAlbum:(PHAssetCollection *)album {
    if (imgArr.count<=0 && !album) {
        return;
    }
   NSMutableArray *identifierArr = [NSMutableArray arrayWithCapacity:imgArr.count];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{//异步子线程上操作

PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
        for (UIImage *img in imgArr) {
            if (img) {
                PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:img];
                PHObjectPlaceholder *assetPlaceholder = [createAssetRequest placeholderForCreatedAsset];
                [albumChangeRequest addAssets:@[assetPlaceholder]];
                [identifierArr addObject:assetPlaceholder.localIdentifier];
            }
        }
        
    } completionHandler:^(BOOL success, NSError *error) {
        NSLog(@"Finished adding asset. %@", (success ? @"Success" : error));

    }];
}
+(void)KLSaveNewPhototWithURLStr:(NSArray<NSString*>*)URLArr{
    if (URLArr.count<=0) {
        return;
    }
    
    NSMutableArray *identifierArr = [NSMutableArray arrayWithCapacity:URLArr.count];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
     PHAssetCollection *album = [[PHAssetCollection alloc]init];
        PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
        for (NSString *urlStr in URLArr) {
            PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:[NSURL URLWithString:urlStr]];
            PHObjectPlaceholder *assetPlaceholder = [assetRequest placeholderForCreatedAsset];
            [albumChangeRequest addAssets:@[assetPlaceholder]];
            [identifierArr addObject:assetPlaceholder.localIdentifier];
        }
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//        NSLog(@"Finished adding asset. %@", (success ? @"Success" : error));
        
         if (success) {
         
         PHFetchResult *result =  [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:identifierArr options:nil];
         NSMutableArray *assetArr = [NSMutableArray array];
         [result enumerateObjectsUsingBlock:^(PHAsset*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//         NSLog(@"%@--%@",obj,[NSThread currentThread]);
         if (obj) {
         [assetArr addObject:obj];
         }
         }];
         
         for (PHAsset *asset in assetArr) {
         [[PHImageManager defaultManager] requestImageDataForAsset:asset
         options:nil
         resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
             
//         NSLog(@"%ld--%@",(long)orientation,info);
         }];
         }
         
         
         }
    }];
}

#pragma mark - 保存视频到相册
+(void)KLSaveNewVideoWithVideoPath:(NSArray<NSString*>*)videoPathArr WithAssetBlock:(AssetArrBlock)assetArr{
    if (videoPathArr.count <= 0) {
        return;
    }
    
    NSMutableArray *identifierArr = [NSMutableArray arrayWithCapacity:videoPathArr.count];
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetCollection *album = [[PHAssetCollection alloc]init];
        PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
        for (NSString *urlPath in videoPathArr) {
         PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL URLWithString:urlPath]];
           PHObjectPlaceholder *assetplaceholder = [assetRequest placeholderForCreatedAsset];
            [albumChangeRequest addAssets:@[assetplaceholder]];
            [identifierArr addObject:assetplaceholder.localIdentifier];
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {//成功
           PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:identifierArr options:nil];
            NSMutableArray *assetArr = [NSMutableArray array];
            NSMutableArray *avAssetArr = [NSMutableArray array];
            
            [result enumerateObjectsUsingBlock:^(PHAsset* _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                if (obj) {
    NSAssert([obj isMemberOfClass:NSClassFromString(@"PHAsset")], @"obj is not PHAsset Class.");
                    [[PHImageManager defaultManager] requestAVAssetForVideo:obj options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                        if (asset) {
                            NSAssert([asset isMemberOfClass:NSClassFromString(@"AVAsset")], @"asset is not AVAsset Class.");
                            [avAssetArr addObject:asset];
                            [assetArr addObject:obj];
                        }
                    }];
                    
                }
            }];
            
            
        }
    }];
}




-(void)dealloc{
    NSLog(@"%@销毁了",self);
}
@end
