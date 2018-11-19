//
//  ViewController.m
//  ToolDemo
//
//  Created by 赵凯乐 on 2018/3/29.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+Category.h"
#import "UIButton+Layout.h"
#import "UIView+KLLayer.h"
#import "CoreAnimateTest.h"
#import "UIImage+Category.h"
#import "KLDrawView.h"
#import "KLAlertController.h"

#import "UserData.h"
#import <GPUImage.h>
#import <UIImageView+WebCache.h>
#import "KLReflectionView.h"
#import "WaveAnimateView.h"//波浪动画

#import "KLPhotoTool.h"
#import "NSObject+KLObjectProperty.h"

#import "UIViewController+KLTranstion.h"
@interface ViewController ()
@property(nonatomic,strong) UIImageView *imgview;
@property(nonatomic,strong) KLDrawView *drawview;
@property(nonatomic,strong)UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
//    CoreAnimateTest *coreAnimate = [[CoreAnimateTest alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:coreAnimate];
    
    WaveAnimateView *waveView = [[WaveAnimateView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
    [self.view addSubview:waveView];
}


-(void)test9{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = self.view.bounds;
    imgView.contentMode = UIViewContentModeScaleToFill;
    imgView.userInteractionEnabled = YES;
    
    [self.view addSubview:imgView];
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:@"https://img-download.pchome.net/download/1k1/kb/37/oprsay-mut.jpg@0e_0o_600w_1024h_90q.src"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc]init];
        filter.blurRadiusInPixels = 5.0;
        //            dispatch_async(dispatch_get_main_queue(), ^{
        imgView.image = [filter imageByFilteringImage:image] ;
        //            });
        //        });
    }];
    
    
    
    UIView *cus = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    cus.backgroundColor = [UIColor whiteColor];
    cus.alpha = 0;
    [imgView addSubview:cus];
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    textview.layer.borderColor = [UIColor redColor].CGColor;
    textview.layer.borderWidth = 1.0;
    textview.layer.cornerRadius = 10;
    textview.font = [UIFont systemFontOfSize:40];
    textview.backgroundColor = [UIColor clearColor];
    textview.textColor = [UIColor redColor];
    [imgView addSubview:textview];
}
/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{


   KLAlertController *alert = [[KLAlertController alloc]init];
   UIView *contentView = [[UIView alloc]init];
    contentView.kl_x = 100;
    contentView.kl_y = 100;
    contentView.kl_size = CGSizeMake(200, 200);
    contentView.backgroundColor = [UIColor redColor];
    [alert configContentView:contentView];
    [self klPresentViewController:alert transtionStyle:(KLTranstionStyleAlert) completion:^{
        
    }];
    
    
//    UserData *user = [[UserData alloc]init];
//    user.name = @"张三";
//    user.birthday = @"2019";
//    user.sex = @"nan";
//    [user saveUserData];
    
//    [self test12];
//    [self test5];
    
//    [self selectImageClicked];

}
*/


/*
-(void)test12{
    KLAlertController *vc = [[KLAlertController alloc]init];
    
    KLAlertViewAnimate *customPresentationController = [[KLAlertViewAnimate alloc]initWithPresentedViewController:vc presentingViewController:self];
    vc.transitioningDelegate = customPresentationController;
    
    [vc configContentView:self.contentView];
    
    [self presentViewController:vc animated:YES completion:nil];
}*/

-(UIView *)contentView{
    if (!_contentView) {
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 200, 300)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius  =20.f;
        contentView.layer.borderColor = [UIColor redColor].CGColor;
        contentView.layer.borderWidth  =2.0f;
        _contentView = contentView;
    }
    return _contentView;
}


-(void)test11{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"KLImage" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:filePath];
    
    [KLPhotoTool KLSaveNewPhototWithURLStr:@[[bundle pathForResource:@"16" ofType:@".jpg"],
                                             [bundle pathForResource:@"17" ofType:@".jpg"],
                                             [bundle pathForResource:@"22" ofType:@".jpg"],
                                             [bundle pathForResource:@"23" ofType:@".jpg"]]];
}
-(void)test10{
    if ([KLPhotoTool KLPhotoPermissions]) {
        
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"此应用没有权限访问相册" preferredStyle:(UIAlertControllerStyleAlert)];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}
-(void)test7{
    KLDrawView *view = [[KLDrawView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 210)];
    view.linewidth = 2.0;
    view.linecolor = [UIColor blackColor];
    view.linemode = kCGBlendModeNormal;
    view.backgroundColor = [UIColor orangeColor];
    self.drawview = view;
    [self.view addSubview:view];
    
   UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), 210)];
    self.imgview = imgView;
    [self.view addSubview:imgView];

}
-(void)test6{
    
    // 1、创建输入图像，CIImage类型，这里使用一个网上图片。
    CIImage *inputImage = [CIImage imageWithContentsOfURL:[NSURL URLWithString:@"http://echo-image.qiniucdn.com/FtPAdyCH-SlO-5xEe009AFE-N0EF?imageMogr2/auto-orient/quality/100%7CimageView2/4/w/640/q/100"]];
    
    // 2、构建一个滤镜图表
    CIColor *sepiaColor = [CIColor colorWithRed:0.76 green:0.65 blue:0.54];
    // 2.1 先构建一个 CIColorMonochrome 滤镜，并配置输入图像与滤镜参数
    CIFilter *monochromeFilter = [CIFilter filterWithName:@"CIColorMonochrome" withInputParameters:@{@"inputColor" : sepiaColor,@"inputIntensity":@1.0}];
    [monochromeFilter setValue:inputImage forKey:@"inputImage"];// 通过KVC来设置输入图像
    // 2.2 先构建一个 CIVignette 滤镜
    CIFilter *vignetteFilter = [CIFilter filterWithName:@"CIVignette" withInputParameters:@{@"inputRadius" : @2.0,@"inputIntensity" :@1.0}];
    [vignetteFilter setValue:monochromeFilter.outputImage forKey:@"inputImage"];// 以monochromeFilter的输出来作为输入
    
    // 3、得到一个滤镜处理后的图片，并转换至 UIImage
    // 创建一个 CIContext
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    // 将 CIImage 过渡到 CGImageRef 类型
    CGImageRef cgImage = [ciContext createCGImage:vignetteFilter.outputImage fromRect:inputImage.extent];
    // 最后转换为 UIImage 类型
    UIImage *uiImage = [UIImage imageWithCGImage:cgImage];
    UIImageView *imgaeView = [[UIImageView alloc]initWithImage:uiImage];
    imgaeView.frame = self.view.frame;
    [self.view addSubview:imgaeView];
    
}
-(void)test5{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.kl_size = CGSizeMake(300, 300);
    imgView.kl_center = self.view.center;
    GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc]init];
    filter.blurRadiusInPixels = 5.0;
    imgView.image = [filter imageByFilteringImage:[UIImage imageNamed:@"KLImage.bundle/13.jpg"]] ;
   
    [self.view addSubview:imgView];
}
-(void)test4{
    UIView *v = [[UIView alloc]init];
    v.kl_size = CGSizeMake(200, 200);
    v.kl_center = self.view.center;
    v.backgroundColor = [UIColor orangeColor];
    
    UIVisualEffectView *glassView = [v kl_glassEffectWithStyle:(UIBlurEffectStyleExtraLight) andRect:v.bounds];
    glassView.backgroundColor = [UIColor magentaColor];
    glassView.alpha = 0.55;
    [v addSubview:glassView];
    [self.view addSubview:v];
    
}
-(void)test3{
    UIView *v = [[UIView alloc]init];
    v.kl_x = 20;
    v.kl_y = 20;
    v.kl_size = CGSizeMake(100, 100);
    v.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:v];

}

-(void)test1{
    //避免重复点击
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(20, 230, 200, 50);
    [btn setTitle:@"间隔2秒点击" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.backgroundColor = [UIColor orangeColor];
//    [btn kl_borderWithRadius:4 andLineWidth:2 andStrokeColor:[UIColor greenColor]];
    btn.custom_acceptEventInterval = 2.0;
    
    [btn addTarget:self action:@selector(btnaction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
//    CGFloat btnW = (self.view.bounds.size.width-40)/5.0;
//    for (int i = 0; i<5; i++) {
//
//        UIButton *testbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        testbtn.frame = CGRectMake(btnW*(i%5)+10*(i%5+1), 100 + 70*(i/5), btnW, 60);
//        [testbtn setImage:[UIImage imageNamed:@"icon-service"] forState:(UIControlStateNormal)];
//        [testbtn setTitle:[NSString stringWithFormat:@"测试 %d",i] forState:UIControlStateNormal];
//        testbtn.backgroundColor = [UIColor magentaColor];
//
//        //        [testbtn kl_systemShadowWithOffset:CGSizeMake(0, 0)
//        //                                 andRadius:5
//        //                                  andColor:[UIColor blackColor]
//        //                                andopacity:.8];
//        [testbtn kl_borderWithRadius:3 andLineWidth:2 andStrokeColor:[UIColor redColor]];
//        [testbtn KL_LayoutButtonWithEdgeInsetsStyle:(KLButtonEdgeInsetsStyleBottom) andSpace:10];
//        [self.view addSubview:testbtn];
//    }
}
-(void)btnaction{
    NSLog(@"间隔2秒点击");

}
#pragma makr - CAReplicatorLayer 动画
-(void)testAnimate1{
    
    /*
    CGSize size = CGSizeMake(100, 100);
    UIColor *color = [UIColor redColor];
    CALayer *itemLayer = [CALayer layer];
    itemLayer.bounds = CGRectMake(0, 0, size.width/6, size.width/6);
    itemLayer.position = CGPointMake(size.width/2, 5);
    itemLayer.cornerRadius = itemLayer.bounds.size.width*0.5;
    itemLayer.backgroundColor = color.CGColor;
    itemLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    //基本动画
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1;
    animation.toValue = @0.1;
    animation.duration = 1.0;
    animation.repeatCount = HUGE_VALF;//重复次数为最大（无限）
    [itemLayer addAnimation:animation forKey:@"animation"];
    
    CAReplicatorLayer *replocatorLayer = [CAReplicatorLayer layer];
    replocatorLayer.frame = CGRectMake(0, 0, size.width, size.height);
    replocatorLayer.position = self.view.center;
    replocatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    NSInteger numOfSpot = 15;
    replocatorLayer.instanceCount = numOfSpot;//包括自己在内的多个图层副本
    CGFloat angle = (M_PI *2.0)/numOfSpot;
    replocatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    replocatorLayer.instanceDelay = 1.0/numOfSpot;//复制副本之间的延迟 默认是0
    [replocatorLayer addSublayer:itemLayer];
    
    [self.view.layer addSublayer:replocatorLayer];
    */
    //关键帧动画
    /*
    CGSize size = CGSizeMake(100, 100);
    UIColor *color = [UIColor redColor];
    CALayer *itemLayer = [CALayer layer];
    itemLayer.bounds = CGRectMake(0, 0, size.width/6, size.width/6);
    itemLayer.position = CGPointMake(size.width/2, 5);
    itemLayer.cornerRadius = itemLayer.bounds.size.width*0.5;
    itemLayer.backgroundColor = color.CGColor;

    CGPoint p0,p1,p2;
    p0 = CGPointMake(size.width*0.5, size.height);
    p1 = CGPointMake(size.width/2.0*(1-cos(M_PI*30/180.0)), size.width/2.0*(1-sin(M_PI*30/180.0)));
    p2 = CGPointMake(size.width/2.0*(1+cos(M_PI*30/180.0)), size.width/2.0*(1-sin(M_PI*30/180.0)));
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.5;
    animation.values = @[[NSValue valueWithCGPoint:p0],
                         [NSValue valueWithCGPoint:p1],
                         [NSValue valueWithCGPoint:p2]];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.repeatCount = HUGE_VALF;
    [itemLayer addAnimation:animation forKey:@"animation"];
    
    NSInteger numOfSpot = 3;
    CAReplicatorLayer *replocatorLayer = [CAReplicatorLayer layer];
    replocatorLayer.frame = CGRectMake(0, 0, size.width, size.height);
    replocatorLayer.position = self.view.center;
    replocatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    replocatorLayer.instanceCount = numOfSpot;
    CGFloat angle = (M_PI*2) / numOfSpot;   // 计算角度
    replocatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    [replocatorLayer addSublayer:itemLayer];
    [self.view.layer addSublayer:replocatorLayer];*/
    
}
//倒影
-(void)reflection{
    KLReflectionView *refView = [[KLReflectionView alloc]initWithFrame:CGRectMake(10, 80, 200, 200)];
    refView.padding = 20.f;
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    img.image = [UIImage imageNamed:@"KLImage.bundle/01.jpg"];
    
    [refView addSubview:img];
    [self.view addSubview:refView];
}
#pragma makr - semaphoreTest
-(void)semaphoreTest{
    /*
     dispatch_semaphore_t semaphore  =  dispatch_semaphore_create(2);//初始化信号量(此方法是相当于控制同时能够多少个任何并发执行,)
     dispatch_semaphore_wait;//当semaphore <= 0 时任务等待(-1操作),可以说是线程阻塞,在它之后的代码将一直等待;
     dispatch_semaphore_signal(semaphore);//(+1操作)
     */
    
   NSBlockOperation * blockOperation = [NSBlockOperation blockOperationWithBlock:^{
       dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
       for (int i = 0; i<20; i++) {
           
           dispatch_async(dispatch_get_global_queue(0, 0), ^{
               NSLog(@"%@",[NSThread currentThread]);
               NSLog(@"上传第===%d===任务",i);
               [NSThread sleepForTimeInterval:3];//沉睡2秒
               dispatch_semaphore_signal(semaphore);//+1
           });
           
           dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//-1
       }
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:blockOperation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
