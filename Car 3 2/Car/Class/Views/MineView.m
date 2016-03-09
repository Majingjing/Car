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
    
    
    self.mineTableView = [[UITableView   alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    //self.mineTableView.backgroundColor = [UIColor  greenColor];
    
    [self addSubview:self.mineTableView];
    
    
    
}



@end
