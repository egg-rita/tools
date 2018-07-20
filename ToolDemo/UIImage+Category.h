//
//  UIImage+Category.h
//  shApp
//
//  Created by 赵凯乐 on 2018/3/27.
//  Copyright © 2018年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 *  水印方向
 */
typedef enum {
    
    //左上
    ImageWaterDirectTopLeft=0,
    
    //右上
    ImageWaterDirectTopRight,
    
    //左下
    ImageWaterDirectBottomLeft,
    
    //右下
    ImageWaterDirectBottomRight,
    
    //正中
    ImageWaterDirectCenter
    
}ImageWaterDirect;


@interface UIImage (Category)
//根据原图压缩图片
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;
+(UIImage*)zipUIimageWithImage:(UIImage*)sorceImage;

- (UIImage *)fixOrientation;//修正图片方向

+(UIImage*)scaleToSize:(UIImage*)img size:(CGSize)size;//根据指定的size生成一张新图

+ (UIImage *)gaussianBlurImage:(UIImage *)image andInputRadius:(CGFloat)radius;/// 对图片进行模糊处理

+ (UIImage *)gaussianBlurImageWithColor:(UIColor *)color andSize:(CGSize)size andInputRadius:(CGFloat)radius;// 由颜色生成模糊图片
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;//指定颜色生成图片

+ (UIImage *)imageWithColor:(UIColor *)color text:(NSString *)name;//获取指定尺寸（50*50）的图片

+ (UIColor *)RGBColor:(NSString *)string;//转换#FFFFFF格式颜色
+ (UIColor *)RGBColor:(NSString *)string alpha:(CGFloat )alpha;//转换#FFFFFF格式颜色

- (BOOL)hasAlpha ;//如果含有透明通道就返回TRUE

- (UIImage *)imageWithAlpha;//如果不存在透明通道就添加透明通道并返回结果
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;//给图片增加透明边框，将图片进行缩放

- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;//创建透明边框

+(UIImage *)scaleImage:(UIImage *)image toScale:(CGFloat)scaleSize;//UIImage等比例缩放

+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;//UIImage自定长宽缩放

- (UIImage *)roundImage;//图片剪切为圆形

+ (UIImage *)cutScreen;//直接截屏

+ (UIImage *)cutFromView:(UIView *)view;//从给定UIView中截图：UIView转UIImage

- (UIImage *)cutWithFrame:(CGRect)frame;//从给定UIImage和指定Frame截图

- (UIImage *)waterWithText:(NSString *)text
                 direction:(ImageWaterDirect)direction
                 fontColor:(UIColor *)fontColor
                 fontPoint:(CGFloat)fontPoint
                  marginXY:(CGPoint)marginXY;//文字水印

- (UIImage *)waterWithWaterImage:(UIImage *)waterImage
                       direction:(ImageWaterDirect)direction
                       waterSize:(CGSize)waterSize
                        marginXY:(CGPoint)marginXY;////绘制图片水印

- (CGRect)calWidth:(NSString *)str
              attr:(NSDictionary *)attr
         direction:(ImageWaterDirect)direction
              rect:(CGRect)rect
          marginXY:(CGPoint)marginXY;//文字水印位置

- (CGRect)rectWithRect:(CGRect)rect
                  size:(CGSize)size
             direction:(ImageWaterDirect)direction
              marginXY:(CGPoint)marginXY;//计算水印位置

+ (UIImage *)animatedGIFWithData:(NSData *)data;//播放动画

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source;//计算动画中每一张图片的播放时间

+ (UIImage *)animatedGIFNamed:(NSString *)name;//播放gif动画

- (UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size;//缩放动画

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;//根据CIImage生成指定大小的UIImage

+ (UIImage*)covertToGrayImageFromImage:(UIImage*)sourceImage;//转成黑白图像

- (UIColor *)colorAtPoint:(CGPoint )point;//获取图片指定位置的颜色

- (UIImage *)flip:(BOOL)isHorizontal;//旋转图片

- (UIImage *)drawLineByImageView:(UIImageView *)imageView;// 返回虚线image的方法

- (UIImage *)imgBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;


@end
