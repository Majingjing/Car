//
//  mosCycleTableViewCell.h
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <UIKit/UIKit.h>

@class morosModel;

@interface mosCycleTableViewCell : UITableViewCell

// 车型页面的信息

// 车的标志
@property (weak, nonatomic) IBOutlet UIImageView *morosImageView;

// 车的名字
@property (weak, nonatomic) IBOutlet UILabel *morosNamelable;

// 车的价格
@property (weak, nonatomic) IBOutlet UILabel *morosPriceLable;


@property (nonatomic,strong)morosModel  *modelMS;

@end
