//
//  KLRequest.m
//  ToolDemo
//
//  Created by PC-013 on 2018/10/22.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLURLRequest.h"


static KLURLRequest  *_requestManager = nil;

@implementation KLURLRequest

+(instancetype)requestManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestManager = [[KLURLRequest alloc]init];
    });
    return _requestManager;
}

+(NSMutableURLRequest*)KLRequestMethod:(RequestMethod)method URLStr:(NSString*)urlStr params:(NSDictionary*)params{
    
    if (!urlStr) {
        urlStr = @"";
    }
    
   urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (method == kGET) {
       NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlStr parameters:params error:nil];
        
        return request;
    }else if ( method == kPOST){
       NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:params error:nil];
        return request;
    }
    return nil;
}
//文件上传
+(NSMutableURLRequest*)formdataWithURLStr:(NSString*)urlStr params:(NSDictionary*)params formdata:(FormDataBlock)formDataBlock{
    if (!urlStr) {
        urlStr = @"";
    }
   urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (formDataBlock) {
                formDataBlock(formData);
            }
        } error:nil];
    
    return request;
    
}



@end
