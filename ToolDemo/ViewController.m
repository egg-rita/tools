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
#import "KLBrowerTestViewController.h"
#import "UIImage+Category.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test3];
//    [self test2];
//    [self test4];
    [self test5];
//    [self test6];
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
//    imgView.image = [UIImage imageNamed:@"01.jpg"];
    imgView.image = [UIImage gaussianBlurImageWithColor:[UIColor magentaColor] andSize:imgView.kl_size andInputRadius:30];
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


-(void)test2{
    KLBrowerTestViewController *vc = [[KLBrowerTestViewController alloc]init];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
}

-(void)test1{
    //避免重复点击
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(20, 20, 200, 50);
    [btn setTitle:@"间隔2秒点击" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.backgroundColor = [UIColor orangeColor];
    [btn kl_borderWithRadius:4 andLineWidth:2 andStrokeColor:[UIColor greenColor]];
    btn.custom_acceptEventInterval = 2.0;
    
    [btn addTarget:self action:@selector(btnaction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    CGFloat btnW = (self.view.bounds.size.width-40)/5.0;
    for (int i = 0; i<5; i++) {
        
        UIButton *testbtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        testbtn.frame = CGRectMake(btnW*(i%5)+10*(i%5+1), 100 + 70*(i/5), btnW, 60);
        [testbtn setImage:[UIImage imageNamed:@"icon-service"] forState:(UIControlStateNormal)];
        [testbtn setTitle:[NSString stringWithFormat:@"测试 %d",i] forState:UIControlStateNormal];
        testbtn.backgroundColor = [UIColor magentaColor];
        
        //        [testbtn kl_systemShadowWithOffset:CGSizeMake(0, 0)
        //                                 andRadius:5
        //                                  andColor:[UIColor blackColor]
        //                                andopacity:.8];
        [testbtn kl_borderWithRadius:3 andLineWidth:2 andStrokeColor:[UIColor redColor]];
        [testbtn KL_LayoutButtonWithEdgeInsetsStyle:(KLButtonEdgeInsetsStyleBottom) andSpace:10];
        [self.view addSubview:testbtn];
    }
}
-(void)btnaction{
    
    NSLog(@"间隔2秒点击");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
