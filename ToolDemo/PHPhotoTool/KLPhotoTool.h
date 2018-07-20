//
//  KLPhotoTool.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/17.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KLPhotoTool : NSObject


//判断应用访问相册的权限
+(BOOL)KLPhotoPermissions;


#pragma mark - 保存照片到相册中

/**
 @param image 指定一张或多张图片
 */
+(void)KLSaveNewAssetWithImage:(UIImage*)image;//指定一张图片
+(void)KLSaveNewAssetWitnImageArr:(NSArray<UIImage*>*)imgArr;//指定多张图片

+(void)KLSaveNewPhototWithURLStr:(NSArray<NSString*>*)URLArr;
@end
