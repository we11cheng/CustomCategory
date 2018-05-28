//
//  DeviceMacro.h
//  TestGwc
//
//  Created by admin on 28/05/2018.
//  Copyright © 2018 guanweicheng. All rights reserved.
//

#ifndef DeviceMacro_h
#define DeviceMacro_h
// UIScreen width.
#define  LL_ScreenWidth   [UIScreen mainScreen].bounds.size.width

// UIScreen height.
#define  LL_ScreenHeight  [UIScreen mainScreen].bounds.size.height
// iPhone X
#define  LL_iPhoneX (LL_ScreenWidth == 375.f && LL_ScreenHeight == 812.f ? YES : NO)

// Status bar height.
#define  LL_StatusBarHeight      (LL_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  LL_NavigationBarHeight  44.f

// Tabbar height.
#define  LL_TabbarHeight         (LL_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  LL_TabbarSafeBottomMargin         (LL_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  LL_StatusBarAndNavigationBarHeight  (LL_iPhoneX ? 88.f : 64.f)

#define LL_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})


#endif /* DeviceMacro_h */
