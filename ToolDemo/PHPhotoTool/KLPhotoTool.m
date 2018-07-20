//
//  KLPhotoTool.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/17.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLPhotoTool.h"
#import <Photos/Photos.h>
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
        /*
        if (success) {
          
           PHFetchResult *result =  [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:identifierArr options:nil];
           NSMutableArray *assetArr = [NSMutableArray array];
            [result enumerateObjectsUsingBlock:^(PHAsset*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@--%@",obj,[NSThread currentThread]);
                if (obj) {
                    [assetArr addObject:obj];
                }
            }];
            
            for (PHAsset *asset in assetArr) {
                [[PHImageManager defaultManager] requestImageDataForAsset:asset
                                                                  options:nil
                                                            resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                                                                NSLog(@"%ld--%@",(long)orientation,info);
                                                            }];
            }
            
            
        }*/
    }];
}
+(void)KLSaveNewPhototWithURLStr:(NSArray<NSString*>*)URLArr{
    
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
        NSLog(@"Finished adding asset. %@", (success ? @"Success" : error));
        
         if (success) {
         
         PHFetchResult *result =  [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:identifierArr options:nil];
         NSMutableArray *assetArr = [NSMutableArray array];
         [result enumerateObjectsUsingBlock:^(PHAsset*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSLog(@"%@--%@",obj,[NSThread currentThread]);
         if (obj) {
         [assetArr addObject:obj];
         }
         }];
         
         for (PHAsset *asset in assetArr) {
         [[PHImageManager defaultManager] requestImageDataForAsset:asset
         options:nil
         resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
         NSLog(@"%ld--%@",(long)orientation,info);
         }];
         }
         
         
         }
    }];
}
-(void)dealloc{
    NSLog(@"%@销毁了",self);
}
@end
