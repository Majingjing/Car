//
//  moroCycleTableViewCell.h
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <UIKit/UIKit.h>

@class moroModel;

@interface moroCycleTableViewCell : UITableViewCell

// 车标志
@property (weak, nonatomic) IBOutlet UIImageView *moroCleImageView;

// 车的名字
@property (weak, nonatomic) IBOutlet UILabel *moroNameLable;


@property (nonatomic,strong)moroModel *modelMTtype;

@end
