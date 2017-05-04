//
//  ShoppingCarTableViewCell.h
//  ShoppingCar
//
//  Created by administrator on 2017/5/3.
//  Copyright © 2017年 JohnLai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarTableViewCell : UITableViewCell

@property (nonatomic,copy) void(^ChoseBtnBlock)(id,BOOL);
@property (nonatomic,assign) NSInteger price;
@property (nonatomic,assign) BOOL selectedStutas;

@end
