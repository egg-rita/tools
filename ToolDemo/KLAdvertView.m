//
//  KLAdvertView.m
//  LL_AdVertScrollView
//
//  Created by zhaokaile on 2018/5/25.
//  Copyright © 2018年 zhaosi. All rights reserved.
//

#import "KLAdvertView.h"
@interface KLAdvertView ()
@property(nonatomic,strong)UIView *firstView;//第一个lab
@property(nonatomic,strong)UIView *secondView;//第二个lab

@property(nonatomic,strong)CADisplayLink *linkTimer;//定时器
@end
@implementation KLAdvertView
-(instancetype)initWithFrame:(CGRect)frame andOneView:(UIView*)oneView andTwoView:(UIView*)twoView{
    if (self = [super initWithFrame:frame]) {
        self.firstView = oneView;
        self.secondView = twoView;
        self.type = ScrollType_bottom;
        [self createInitData];
        [self createUI];
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)createInitData{

    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(startUpdateUI) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
-(void)createUI{
    [self addSubview:self.firstView];
    [self addSubview:self.secondView];
}


-(void)startUpdateUI{

    CGRect oneRect = self.firstView.frame;
    CGRect twoRect = self.secondView.frame;
    
    switch (_type) {
        case ScrollType_bottom:
            if (oneRect.origin.y > twoRect.origin.y) {
                [UIView animateWithDuration:0.75
                                 animations:^{
                                     self.firstView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
                                     self.secondView.frame = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
                                 }
                                 completion:^(BOOL finished) {
                                     self.secondView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
                                 }];
            }else if (oneRect.origin.y < twoRect.origin.y){
                [UIView animateWithDuration:0.75
                                 animations:^{
                                     self.firstView.frame = CGRectMake(0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
                                     self.secondView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
                                 }
                                 completion:^(BOOL finished) {
                                     self.firstView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
                                 }];
            }
            break;
            
        default:
            break;
    }
    
    
    
}

#pragma mark - getter
-(UIView *)firstView{
    if (!_firstView) {
        _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _firstView.backgroundColor = [UIColor orangeColor];
    }
    return _firstView;
}
-(UIView *)secondView{
    if (!_secondView) {
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
        _secondView.backgroundColor = [UIColor greenColor];
    }
    return _secondView;
}
-(void)setType:(ScrollType)type{
    _type = type;
    switch (_type) {
        case ScrollType_bottom:
        {
            self.firstView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            self.secondView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
        }
            break;
            
        default:
            break;
    }
}
-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
}
@end
