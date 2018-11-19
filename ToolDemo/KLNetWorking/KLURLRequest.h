//
//  KLRequest.h
//  ToolDemo
//
//  Created by PC-013 on 2018/10/22.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFURLRequestSerialization.h>

typedef void(^FormDataBlock)(id<AFMultipartFormData> _Nonnull formData);


typedef NS_ENUM(NSUInteger ,RequestMethod){
    kGET = 0,
    kPOST = 1,
};



@interface KLURLRequest : NSObject

/**
 数据请求

 @param method <#method description#>
 @param urlStr <#urlStr description#>
 @param params <#params description#>
 @return <#return value description#>
 */
+(NSMutableURLRequest*)KLRequestMethod:(RequestMethod)method URLStr:(NSString*)urlStr params:(NSDictionary*)params;

//文件上传
+(NSMutableURLRequest*)formdataWithURLStr:(NSString*)urlStr params:(NSDictionary*)params formdata:(FormDataBlock)formDataBlock;

@end
