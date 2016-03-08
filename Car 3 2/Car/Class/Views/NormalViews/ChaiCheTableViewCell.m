//
//  ChaiCheTableViewCell.m
//  Car
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "ChaiCheTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface ChaiCheTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *myImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation ChaiCheTableViewCell



-(void)setModel:(ChaiCheModel *)model{
    _model = model;
    [self.myImgView sd_setImageWithURL:[NSURL URLWithString:model.covimg] placeholderImage:[UIImage imageNamed:@"chachewenzhang"]];
    self.titleLabel.text = model.title;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
