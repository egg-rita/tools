//
//  KLURLResponse.h
//  ToolDemo
//
//  Created by PC-013 on 2018/10/22.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFURLResponseSerialization.h>

typedef void(^_Nullable SuccessBlock)(id responseObject);
typedef void(^_Nullable FailureBlock)(NSError *error);
typedef void(^_Nullable UploadProgressBlock)(NSProgress *progress);
@interface KLURLResponse : NSObject

+(AFJSONResponseSerializer*)createJsonSerializer;

@end
