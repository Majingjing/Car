//
//  ModelCollectionViewCell.m
//  Car
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "ModelCollectionViewCell.h"

@implementation ModelCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupItem];
    }
    return self;
}

- (void)setupItem {
    self.lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, self.contentView.frame.size.width, 30)];
    self.lable.font = [UIFont systemFontOfSize:16];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 120)];
    [self.contentView addSubview:self.lable];
    [self.contentView addSubview:self.imageView];
}



@end
