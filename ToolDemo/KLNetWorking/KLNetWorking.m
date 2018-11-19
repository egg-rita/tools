//
//  KLNetWorking.m
//  ToolDemo
//
//  Created by PC-013 on 2018/10/22.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLNetWorking.h"
#import "KLURLRequest.h"
#import "KLURLResponse.h"
#import <AFURLSessionManager.h>

#define kTimeOut  20
static KLNetWorking *_netWorkingManager = nil;
@implementation KLNetWorking
+(instancetype)NetWorkingManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _netWorkingManager = [[KLNetWorking class] init];
    });
    return _netWorkingManager;
    
}
//POST 请求
+(void)klPostRequestWithURLString:(NSString*)urlString
                           params:(NSDictionary*)params
                          success:(SuccessBlock)successBlock
                          failure:(FailureBlock)failureBlock{
    
    NSMutableURLRequest *request = [KLURLRequest KLRequestMethod:kPOST URLStr:urlString params:params];
    
}
//GET 请求
+(void)klGetRequestWithURLString:(NSString*)urlString
                          params:(NSDictionary*)params
                         success:(SuccessBlock)successBlock
                         failure:(FailureBlock)failureBlock{
    NSMutableURLRequest *request = [KLURLRequest KLRequestMethod:kGET URLStr:urlString params:params];
    
}

/**
 请求数据的基类
 @param request
 @param serializer 默认是json
 @param securityPolicy https安全策略 默认是defaultPolicy
 @param successBlock
 @param failureBlock
 */
+(void)KLSendDataRequestWithRequest:(NSMutableURLRequest*)request
                    responseSerializer:(id<AFURLResponseSerialization>)serializer
                     securityPolicy:(AFSecurityPolicy*)securityPolicy
                           success:(SuccessBlock)successBlock
                           failure:(FailureBlock)failureBlock{
    
    request.timeoutInterval = kTimeOut;
    
    AFURLSessionManager *session = [[AFURLSessionManager alloc]initWithSessionConfiguration:nil];
    
    if (!securityPolicy) {
        session.securityPolicy = [AFSecurityPolicy defaultPolicy];//
    }else{
        session.securityPolicy = securityPolicy;
    }
    
    if (!serializer) {//默认是json
        session.responseSerializer = [KLURLResponse createJsonSerializer];
    }else{
        session.responseSerializer = serializer;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
   NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil
               completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
           [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                   dispatch_async(dispatch_get_global_queue(0, 0), ^{
           [[KLNetWorking NetWorkingManager].dataTaskArr removeObject:dataTask];//取消任务
                       if (error) {//失败
                           if (failureBlock) {
                               failureBlock(error);
                           }
                       }else{//成功
                           if (successBlock) {
                               successBlock(responseObject);
                           }
                       }
                   });

               }];
    
    [[KLNetWorking NetWorkingManager].dataTaskArr addObject:dataTask];//添加正在请求的任务
    [dataTask resume];
    
}

/**
 上传文件 图片

 */
+(void)uploafFileWithURLString:(NSString*)urlStr Parmas:(NSDictionary*)params DataArr:(NSArray<NSData*>*)dataArr Name:(NSString*)nameStr MimeType:(NSString*)mimeTypeStr UploadProgress:(UploadProgressBlock)progressBlock Success:(SuccessBlock)successBlock Failure:(FailureBlock)failureBlock{
    
    NSMutableURLRequest *request = [KLURLRequest formdataWithURLStr:urlStr params:params formdata:^(id<AFMultipartFormData>  _Nonnull formData) {
        [dataArr enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //给数据设置名称
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *fileName = [formatter stringFromDate:[NSDate date]];
            fileName  = [fileName stringByAppendingFormat:@""];
            
            [formData appendPartWithFileData:obj name:nameStr  fileName:fileName mimeType:mimeTypeStr];
        }];
    }];
    [self SendUploadFileWithRequest:request responseSerializer:nil securityPolicy:nil uploadProgress:progressBlock successBlock:successBlock failure:failureBlock];
}

+(void)SendUploadFileWithRequest:(NSMutableURLRequest*)request
              responseSerializer:(id<AFURLResponseSerialization>)serializer
                  securityPolicy:(AFSecurityPolicy*)securityPolicy
                  uploadProgress:(UploadProgressBlock)progressBlock
                    successBlock:(SuccessBlock)successBlock
                         failure:(FailureBlock)failureBlock{
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:nil];
    
    if (!serializer) {//默认
        sessionManager.responseSerializer = [KLURLResponse createJsonSerializer];
    }else{
        sessionManager.responseSerializer = serializer;
    }
    if (!securityPolicy) {//默认
        sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    }else{
        sessionManager.securityPolicy = securityPolicy;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   NSURLSessionUploadTask *uploadTask = [sessionManager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [[KLNetWorking NetWorkingManager].uploadDataTaskArr removeObject:uploadTask];
        
        if (error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }else{
            if (successBlock) {
                successBlock(responseObject);
            }
        }
    }];
    [[KLNetWorking NetWorkingManager].uploadDataTaskArr addObject:uploadTask];
    [uploadTask resume];
}



#pragma mark - Lazy
-(NSMutableArray *)dataTaskArr{
    if (!_dataTaskArr) {
        _dataTaskArr = [NSMutableArray array];
    }
    return _dataTaskArr;
}
-(NSMutableArray *)uploadDataTaskArr{
    if (!_uploadDataTaskArr) {
        _uploadDataTaskArr = [NSMutableArray array];
    }
    return _uploadDataTaskArr;
}
@end
