//
//  KLBlurreView.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/12.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLBlurreView.h"
#import "UIImage+Category.h"
#import <GPUImage.h>
@implementation KLBlurreView

- (void)drawRect:(CGRect)rect {

        GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];

        blurFilter.blurRadiusInPixels = 10.0;//0~10.0,
        UIImage * image = [UIImage imageNamed:@"04.jpg"];
        UIImage *blurredImage = [blurFilter imageByFilteringImage:image];

        [blurredImage drawInRect:self.bounds];
    
}


@end
