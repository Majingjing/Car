//
//  RegiserViewController.h
//  Car
//
//  Created by lanou3g on 16/3/9.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sendMessageDelegate <NSObject>

-(void)sendValue:(NSString *)name word:(NSString *)word;

@end

@interface RegiserViewController : UIViewController

@property (nonatomic,assign) id <sendMessageDelegate>delegate;

@end
