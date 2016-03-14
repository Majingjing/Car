//
//  InformationTableViewCell.m
//  Car
//
//  Created by mj on 16/3/2.
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
    self.titleLabel.textColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    self.subheadLabel.text = model.subhead;
    
//    self.subheadLabel.font = [UIFont systemFontOfSize:15];
//    CGSize size = CGSizeMake(self.subheadLabel.frame.size.width, 20000);
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
//    CGRect rect = [model.subhead boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
//    CGRect frame = self.subheadLabel.frame;
//    frame.size.height = rect.size.height;
//    self.subheadLabel.frame = frame;
//    
    
    self.subheadLabel.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:model.coverpic] placeholderImage:[UIImage imageNamed:@""]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
