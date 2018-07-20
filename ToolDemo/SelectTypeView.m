//
//  SelectTypeView.m
//  ToolDemo
//
//  Created by zhaokaile on 2018/7/18.
//  Copyright © 2018年 赵凯乐. All rights reserved.
//

#import "SelectTypeView.h"
@interface SelectTypeView()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)NSMutableArray *btnArr;
@end
@implementation SelectTypeView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    [self addSubview:self.titleLab];
    
    
}
-(void)layoutSubviews{
    self.titleLab.frame = CGRectMake(14, 20, CGRectGetWidth(self.frame)-28, self.titleLab.font.lineHeight);
    
    NSInteger index = 0;
    CGFloat padding = 20.0;//间距
    CGFloat w = (self.bounds.size.width-120)/3;
    for (NSString *str in self.btnTitleArr) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.tag = index;
        btn.frame = CGRectMake(w*index+(index+1)*padding, 55, w, 40);
        [btn setTitle:str forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [btn setTitleColor:nil forState:(UIControlStateSelected)];
        btn.layer.borderColor = nil;
        btn.layer.borderWidth = 1.0;
        btn.layer.cornerRadius = 3;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(touchBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
        [self.btnArr addObject:btn];
        index++;
    }
}

-(void)touchBtnAction:(UIButton*)sender{
    self.hidden = YES;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLab.text = _title;
}




-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font =[UIFont systemFontOfSize:18];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.backgroundColor = [UIColor whiteColor];
        
    }
    return _titleLab;
}

-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr  =[NSMutableArray arrayWithCapacity:self.btnTitleArr.count];
    }
    return _btnArr;
}


-(void)dealloc{
    NSLog(@"%@销毁了!!",self);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
