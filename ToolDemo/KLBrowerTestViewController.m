//
//  KLBrowerTestViewController.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/6/8.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "KLBrowerTestViewController.h"

@interface KLBrowerTestViewController ()
@property(nonatomic,strong)NSMutableArray *locationImgArr;
@end

@implementation KLBrowerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger clo = 3;
    CGFloat wh = (self.view.bounds.size.width-40)/clo;
    for (int i = 0; i<self.locationImgArr.count; i++) {
        
       NSString *str = self.locationImgArr[i];
       UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10*(i%clo+1)+wh*(i%clo), 20+10*(i/clo)+wh*(i/clo), wh, wh)];
        imgView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
        imgView.image = [UIImage imageNamed:str];
        [imgView addGestureRecognizer:tap];
        [self.view addSubview:imgView];
    }
   
}

-(void)clickImage:(UITapGestureRecognizer*)tap{
    
}



-(NSMutableArray *)locationImgArr{
    if (!_locationImgArr) {
        _locationImgArr = [NSMutableArray arrayWithArray:@[@"localImage0.jpeg",@"localImage1.jpeg",@"localImage2.jpeg",@"localImage3.jpeg",@"localImage4.jpeg",@"localImage5.jpeg",@"localImage6.jpeg",@"localImage7.jpeg",@"localImage8.jpeg"]];
//        [_locationImgArr addObjectsFromArray:@[@"localImage0.jpeg",@"localImage1.jpeg",@"localImage2.jpeg",@"localImage3.jpeg",@"localImage4.jpeg",@"localImage5.jpeg",@"localImage6.jpeg",@"localImage7.jpeg",@"localImage8.jpeg",]];
    }
    return _locationImgArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
