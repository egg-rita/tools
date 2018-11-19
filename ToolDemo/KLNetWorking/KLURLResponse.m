//
//  KLURLResponse.m
//  ToolDemo
//
//  Created by PC-013 on 2018/10/22.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLURLResponse.h"

@implementation KLURLResponse
+(AFJSONResponseSerializer*)createJsonSerializer{
    AFJSONResponseSerializer *jsonserializer = [AFJSONResponseSerializer serializer];
    [jsonserializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",
                                                                    @"text/plain",
                                                                    @"text/javascript",
                                                                    @"text/json",
                                                                    @"text/css",
                                                                    @"application/javascript",
                                                                    @"text/html", nil]];
    return jsonserializer;
}

@end
