//
//  MJRootView.m
//  Car
//
//  Created by mj on 16/3/1.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "MJRootView.h"

static MJRootView *MJView;
@interface MJRootView ()

@property (nonatomic, strong) UIButton *popButton;
@property (nonatomic, strong)NSArray *arr;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)UILabel *lable;

@end

@implementation MJRootView

+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MJView = [[MJRootView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        MJView.layer.masksToBounds = YES;
        MJView.layer.cornerRadius = 30;
        
        MJView.center = CGPointMake(Width / 2, Height - 30);
        MJView.backgroundColor = [UIColor colorWithRed:0.977 green:0.957 blue:1.000 alpha:0.7];
        
    });
    return MJView;
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arr = @[@"资讯", @"车型", @"拆车坊", @"图片", @"我的"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downAction) name:@"downAction" object:nil];

        [self setupView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downAction)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

- (void)setupView {
    self.popButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.popButton.frame = CGRectMake(0, 0, 60, 60);
//    self.popButton.backgroundColor = [UIColor colorWithRed:0.693 green:0.974 blue:1.000 alpha:1.000];
    [self.popButton setBackgroundImage:[UIImage imageNamed:@"14.png"] forState:UIControlStateNormal];
    self.popButton.layer.cornerRadius = 30;
    [self.popButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.popButton];
    [self addButtons];
}

- (void)addButtons {
    CGFloat width = (Width - 60) / 5;
    for (int i = 0; i < 5; i++) {
        if (i == 0 || i == 4) {
            self.button = [[UIButton alloc] initWithFrame:CGRectMake((width  + 10)* i + 10 , Height - 130, width, width)];
            self.lable = [[UILabel alloc] initWithFrame:CGRectMake((width  + 10)* i + 10 , Height - 60, width, 30)];
            
        }
        if (i == 3) {
            self.button = [[UIButton alloc] initWithFrame:CGRectMake((width  + 20)* i + 10 , Height - 220, width, width)];
            self.lable = [[UILabel alloc] initWithFrame:CGRectMake((width  + 20)* i + 10 , Height - 150, width, 30)];
            
            
        }
        if (i == 1) {
            self.button = [[UIButton alloc] initWithFrame:CGRectMake((width - 10) * i + 10 , Height - 220, width, width)];
            self.lable = [[UILabel alloc] initWithFrame:CGRectMake((width - 10)* i + 10 , Height - 150, width, 30)];
        }
        if (i == 2) {
            self.button = [[UIButton alloc] initWithFrame:CGRectMake((width  + 10)* i + 10 , Height - 260, width, width)];
            self.lable = [[UILabel alloc] initWithFrame:CGRectMake((width  + 10)* i + 10 , Height - 190, width, 30)];
        }
         [self.button setBackgroundImage:[UIImage imageNamed:self.arr[i]] forState:UIControlStateNormal];
        self.button.tag = 100+i;
        self.lable.text = self.arr[i];
        self.lable.textAlignment = NSTextAlignmentCenter;
        self.button.layer.cornerRadius = width / 2;
        [self.button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        [self addSubview:self.lable];
        
    }
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(Width / 2 - 20, Height - 40, 40, 40)];
    [button setTitle:@"X" forState:UIControlStateNormal];
    button.font = [UIFont systemFontOfSize:35];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(downAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [UIColor colorWithRed:0.487 green:1.000 blue:0.682 alpha:1.000];

}





- (void)buttonAction:(UIButton *)sender {
    MJView.layer.cornerRadius = 0;
    MJView.frame = [UIScreen mainScreen].bounds;

    self.popButton.hidden = YES;
}

- (void)tapAction:(UIButton *)sender {

    [self.delegate jumpAction:sender.tag];
}


- (void)downAction {
    self.popButton.hidden = NO;
    MJView.layer.cornerRadius = 30;
    MJView.frame = CGRectMake(0, 0, 60, 60);
    MJView.center = CGPointMake(Width / 2, Height - 30);
}

@end
