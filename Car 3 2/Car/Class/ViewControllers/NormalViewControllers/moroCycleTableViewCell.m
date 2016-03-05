//
//  moroCycleTableViewCell.m
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "moroCycleTableViewCell.h"

#import "moroModel.h"


#import "UIImageView+WebCache.h"
@implementation moroCycleTableViewCell

-(void)setModelMTtype:(moroModel *)modelMTtype{
    
    // 车标
    _moroNameLable.text = modelMTtype.brandName;
    
    // 车的图片
    
    [self.moroCleImageView sd_setImageWithURL:[NSURL URLWithString:modelMTtype.logo] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    
    
}


@end
