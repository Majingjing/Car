//
//  PicCollectionViewCell.m
//  Car
//
//  Created by jiabin on 16/3/10.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "PicCollectionViewCell.h"

@implementation PicCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupItem];
    }
    return self;
}

-(void)setupItem{
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    
    self.imageView.backgroundColor = [UIColor greenColor];
    
    [self.contentView addSubview:self.imageView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    self.imageView.frame = self.contentView.bounds;
}


@end
