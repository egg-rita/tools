//
//  KLImageBrowserUtilities.h
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if DEBUG
#define KLLOG(format, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
#else
#define KLLOG(format, ...) nil
#endif

#define KLLOG_WARNING(discribe) KLLOG(@"%@ ⚠️ SEL-%@ %@", self.class, NSStringFromSelector(_cmd), discribe)
#define KLLOG_ERROR(discribe) KLLOG(@"%@ ❌ SEL-%@ %@", self.class, NSStringFromSelector(_cmd), discribe)


#define KL_NORMALWINDOW [KLImageBrowserUtilities getNormalWindow]

#define KL_IS_IPHONEX (YB_SCREEN_HEIGHT == 812)
#define KL_HEIGHT_EXTRABOTTOM (YB_IS_IPHONEX ? 34.0 : 0)
#define KL_HEIGHT_STATUSBAR (YB_IS_IPHONEX ? 44.0 : 20.0)

#define KL_HEIGHT_TOOLBAR (YB_HEIGHT_STATUSBAR + 44)

#define KL_MAINTHREAD_ASYNC(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

FOUNDATION_EXTERN NSString * const KLImageBrowser_KVCKey_browserView;
FOUNDATION_EXTERN NSString * const KLImageBrowser_notification_willToRespondsDeviceOrientation;
FOUNDATION_EXTERN NSString * const KLImageBrowser_notification_changeAlpha;
FOUNDATION_EXTERN NSString * const KLImageBrowser_notificationKey_changeAlpha;
FOUNDATION_EXTERN NSString * const KLImageBrowser_notification_hideBrowerView;
FOUNDATION_EXTERN NSString * const KLImageBrowser_notification_showBrowerView;
FOUNDATION_EXTERN NSString * const KLImageBrowser_notification_willShowBrowerViewWithTimeInterval;
FOUNDATION_EXTERN NSString * const KLImageBrowser_notificationKey_willShowBrowerViewWithTimeInterval;

typedef NS_ENUM(NSUInteger,KLImageBrowserImageViewFillType){
    KLImageBrowserImageViewFillTypeFullWidth,   //宽度抵满屏幕宽度，高度不定
    KLImageBrowserImageViewFillTypeCompletely   //保证图片完整显示情况下最大限度填充
};
typedef NS_ENUM(NSUInteger,KLImageBrowserScreenOrientation){
    KLImageBrowserScreenOrientationUnknown, //未知
    KLImageBrowserScreenOrientationVertical, //屏幕竖直方向展示
    KLImageBrowserScreenOrientationHorizontal   //屏幕水平方向展示
};
typedef NS_ENUM(NSUInteger, KLImageBrowserAnimation) {
    KLImageBrowserAnimationNone,    //无动画
    KLImageBrowserAnimationFade,    //渐隐
    KLImageBrowserAnimationMove     //移动
};

@interface KLImageBrowserUtilities : NSObject

+ (BOOL)isGif:(NSData *)data;
+ (UIViewController *)getTopController;
+ (UIWindow *)getNormalWindow;
+ (CGFloat)getWidthWithAttStr:(NSAttributedString *)attStr;
+ (UIImage *)scaleToSizeWithImage:(UIImage *)image size:(CGSize)size;
+ (UIImage *)cutToRectWithImage:(UIImage *)image rect:(CGRect)rect;
+ (void)countTimeConsumingOfCode:(void(^)(void))code;
@end
