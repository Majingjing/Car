//
//  MineView.m
//  Car
//
//  Created by 史燕红 on 16/3/8.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "MineView.h"

@implementation MineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self   setUpview];
    }
    return self;
}

-(void)setUpview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    imgView.image = [UIImage imageNamed:@"backimage"];
    [self addSubview:imgView];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginBtn.frame = CGRectMake(Width/2-40, Height*0.2-40, 80, 80);
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"用户"] forState:UIControlStateNormal];
    imgView.userInteractionEnabled = YES;
    [imgView addSubview:self.loginBtn];
    
    self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(Width/2-40, Height*0.2+40, 80, 30)];
    self.stateLabel.text = @"点击登录";
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    [imgView addSubview:self.stateLabel];
    
    self.mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height*0.4, Width, Height*0.6) style:UITableViewStylePlain];
    self.mineTableView.alpha = 0.7;
    self.mineTableView.bounces = NO;
    [self addSubview:self.mineTableView];
    
 
}



@end











