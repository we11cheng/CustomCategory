//
//  Gesture.m
//  DWGesture
//
//  Created by dwang_sui on 16/7/14.
//  Copyright © 2016年 dwang_sui. All rights reserved.
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//--------------------------------------------------QQ:739814184------------------------------------++++++
//--------------------------------------------------微信:ai739814184---------------------------------+++++
//--------------------------------------------------Email:dwang.hello@outlook.com-------------------+++
//-------------------------简书地址:http://www.jianshu.com/users/75afc06dcc73/latest_articles --------+
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#import "DWSwipeGestures.h"

@interface DWSwipeGestures ()

/**
 *  手势所添加的视图
 */
@property (weak, nonatomic) UIView *view;

/**
 *  敲击手势
 */
@property (weak, nonatomic) UITapGestureRecognizer *tapGesture;

/**
 *  左滑手势
 */
@property (weak, nonatomic) UISwipeGestureRecognizer *leftSwipeStures;

/**
 *  右滑手势
 */
@property (weak, nonatomic) UISwipeGestureRecognizer *rightSwipeStures;

/**
 *  上拉手势
 */
@property (weak, nonatomic) UISwipeGestureRecognizer *upSwipeStures;

/**
 *  下拉手势
 */
@property (weak, nonatomic) UISwipeGestureRecognizer *downSwipeStures;


@end

@implementation DWSwipeGestures


- (void)dw_SwipeGestureType:(DWSwipeGestureType)swipeGestureType Target:(nullable id)target Action:(nullable SEL)action AddView:(UIView * _Nonnull)view BackSwipeGestureTypeString:(void(^ _Nonnull )(NSString *_Nonnull backSwipeGestureTypeString))backSwipeGestureTypeString {
    
    self.view = view;
    
    if (swipeGestureType == DWTapGesture) {
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        
        [self dw_SetNumberOfTapsRequiredFrome:tapGesture];
        
        self.swipeGestureType = DWTapGesture;
        
        self.tapGesture = tapGesture;
        
        [view addGestureRecognizer:tapGesture];
        
    } else if (swipeGestureType == DWLeftSwipeGestures) {
        
        UISwipeGestureRecognizer *leftSwipeStures = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
        
        leftSwipeStures.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [self dw_SetNumberOfTouchesRequired:leftSwipeStures];
        
        self.swipeGestureType = DWLeftSwipeGestures;
        
        self.leftSwipeStures = leftSwipeStures;
        
        [view addGestureRecognizer:leftSwipeStures];
        
    } else if (swipeGestureType == DWRightSwipeGestures) {
        
        UISwipeGestureRecognizer *rightSwipeStures = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
        
        [self dw_SetNumberOfTouchesRequired:rightSwipeStures];
        
        self.swipeGestureType = DWRightSwipeGestures;
        
        self.rightSwipeStures = rightSwipeStures;
        
        [view addGestureRecognizer:rightSwipeStures];
        
    } else if (swipeGestureType == DWUpSwipeGestures) {
        
        UISwipeGestureRecognizer *upSwipeStures = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
        
        upSwipeStures.direction = UISwipeGestureRecognizerDirectionUp;
        
        [self dw_SetNumberOfTouchesRequired:upSwipeStures];
        
        self.swipeGestureType = DWUpSwipeGestures;
        
        self.upSwipeStures = upSwipeStures;
        
        [view addGestureRecognizer:upSwipeStures];
        
    } else if (swipeGestureType == DWDownSwipeGestures) {
        
        UISwipeGestureRecognizer *downSwipeStures = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
        
        downSwipeStures.direction = UISwipeGestureRecognizerDirectionDown;
        
        [self dw_SetNumberOfTouchesRequired:downSwipeStures];
        
        self.swipeGestureType = DWDownSwipeGestures;
        
        self.downSwipeStures = downSwipeStures;
        
        [view addGestureRecognizer:downSwipeStures];
        
    }
    
    switch (swipeGestureType) {
        case DWTapGesture:
            
            if (backSwipeGestureTypeString) {
                
                backSwipeGestureTypeString(@"敲击手势");
                
            }
            
            break;
            
        case DWLeftSwipeGestures:
            
            if (backSwipeGestureTypeString) {
                
                backSwipeGestureTypeString(@"左滑手势");
                
            }
            
            break;
            
        case DWRightSwipeGestures:
            
            if (backSwipeGestureTypeString) {
                
                backSwipeGestureTypeString(@"右滑手势");
                
            }
            
            break;
            
        case DWUpSwipeGestures:
            
            if (backSwipeGestureTypeString) {
                
                backSwipeGestureTypeString(@"上拉手势");
                
            }
            
            break;
            
        case DWDownSwipeGestures:
            
            if (backSwipeGestureTypeString) {
                
                backSwipeGestureTypeString(@"下拉手势");
                
            }
            
            break;
            
        default:
            break;
    }
}

- (void)dw_SetNumberOfTapsRequiredFrome:(UITapGestureRecognizer *)swipeGesture {
    
    if (self.numberOfTapsRequired) {
        
        swipeGesture.numberOfTapsRequired = self.numberOfTapsRequired;
        
    }
    
    if (self.numberOfTouchesRequired) {
        
        swipeGesture.numberOfTouchesRequired = self.numberOfTouchesRequired;
        
    }
    
}

- (void)dw_SetNumberOfTouchesRequired:(UISwipeGestureRecognizer *)swipeGesture {
    
    if (self.numberOfTouchesRequired) {
        
        swipeGesture.numberOfTouchesRequired = self.numberOfTouchesRequired;
        
    }

    
}

- (void)setNumberOfTapsRequired:(NSInteger)numberOfTapsRequired {
    
    if (numberOfTapsRequired < 0) {
        
        numberOfTapsRequired = 1;
        
    }
    
    _numberOfTapsRequired = numberOfTapsRequired;
    
}

- (void)setNumberOfTouchesRequired:(NSInteger)numberOfTouchesRequired {
    
    if (numberOfTouchesRequired < 0) {
        
        numberOfTouchesRequired = 1;
        
    }
    
    _numberOfTouchesRequired = numberOfTouchesRequired;
    
}

- (void)dw_RemoveSwipeGesture:(DWSwipeGestureType)swipeGestureType {
    
    switch (swipeGestureType) {
        case DWTapGesture:
            
            [self.view removeGestureRecognizer:self.tapGesture];
            
            break;
            
        case DWLeftSwipeGestures:
            
            [self.view removeGestureRecognizer:self.leftSwipeStures];
            
            break;
            
        case DWRightSwipeGestures:
            
            [self.view removeGestureRecognizer:self.rightSwipeStures];
            
            break;
            
        case DWUpSwipeGestures:
            
            [self.view removeGestureRecognizer:self.upSwipeStures];
            
            break;
            
        case DWDownSwipeGestures:
            
            [self.view removeGestureRecognizer:self.downSwipeStures];
            
            break;
            
        default:
            break;
    }
    
    
}

@end
