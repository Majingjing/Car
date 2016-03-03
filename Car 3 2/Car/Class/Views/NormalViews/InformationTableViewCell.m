//
//  InformationTableViewCell.m
//  Car
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "InformationTableViewCell.h"
#import "InformationModel.h"
#import "UIImageView+WebCache.h"
@interface InformationTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subheadLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;

@end

@implementation InformationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setModel:(InformationModel *)model {
    self.titleLabel.text = model.title;
    self.subheadLabel.text = model.subhead;
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.coverpic]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
