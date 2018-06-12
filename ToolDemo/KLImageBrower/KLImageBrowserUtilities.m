//
//  KLImageBrowserUtilities.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLImageBrowserUtilities.h"

NSString * const KLImageBrowser_KVCKey_browserView = @"browserView";
NSString * const KLImageBrowser_notification_willToRespondsDeviceOrientation = @"KLImageBrowser_notification_willToRespondsDeviceOrientation";
NSString * const KLImageBrowser_notification_changeAlpha = @"KLImageBrowser_notification_changeAlpha";
NSString * const KLImageBrowser_notificationKey_changeAlpha = @"KLImageBrowser_notificationKey_changeAlpha";
NSString * const KLImageBrowser_notification_hideBrowerView = @"KLImageBrowser_notification_hideBrowerView";
NSString * const KLImageBrowser_notification_showBrowerView = @"KLImageBrowser_notification_showBrowerView";
NSString * const KLImageBrowser_notification_willShowBrowerViewWithTimeInterval = @"KLImageBrowser_notification_willShowBrowerViewWithTimeInterval";
NSString * const KLImageBrowser_notificationKey_willShowBrowerViewWithTimeInterval = @"KLImageBrowser_notification_willShowBrowerViewWithTimeInterval";

@implementation KLImageBrowserUtilities
+(BOOL)isGif:(NSData *)data{
   return [[self getTypeOfImageDta:data] isEqualToString:@"gif"];
}
+(NSString*)getTypeOfImageDta:(NSData*)data{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x4D:
            return @"fiff";
        case 0x52:
        {
            if ([data length]<12) {
                return nil;
            }
            NSString *testString = [[NSString alloc]initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"]&&[testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
        }
        default:
            return nil;
    }
}
+(UIViewController*)getTopController{
    UIViewController *topController = nil;
    UIWindow *win = [self getNormalWindow];
    UIView *frontView = [[win subviews]objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:NSClassFromString(@"UIViewController")]) {
        topController = nextResponder;
    }else{
        topController = win.rootViewController;
    }
    return topController;
}
+ (UIWindow *)getNormalWindow{
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    if (win.windowLevel != UIWindowLevelNormal) {
        NSArray *windiws =[UIApplication sharedApplication].windows;
        for (UIWindow *temp in windiws) {
            if (temp.windowLevel== UIWindowLevelNormal) {
                win = temp;
                break;
            }
        }
    }
    
    return win;
}

+ (CGFloat)getWidthWithAttStr:(NSAttributedString *)attStr {
    return [attStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
}

+(UIImage *)scaleToSizeWithImage:(UIImage *)image size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImg;
}

+(UIImage *)cutToRectWithImage:(UIImage *)image rect:(CGRect)rect{
    CGImageRef _cgImage = image.CGImage;
    CGImageRef cgImage =CGImageCreateWithImageInRect(_cgImage, rect);
    UIImage *resultImg = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImg;
}
+ (void)countTimeConsumingOfCode:(void(^)(void))code {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    code?code():nil;
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
    KLLOG(@"TimeConsuming: %f ms", linkTime *1000.0);
}
@end
