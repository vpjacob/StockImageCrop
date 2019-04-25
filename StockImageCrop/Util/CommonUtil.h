//
//  CommonUtil.h
//  StockImageCrop
//
//  Created by linkface on 2019/4/25.
//  Copyright © 2019 ca. All rights reserved.
//

#ifndef CommonUtil_h
#define CommonUtil_h

#define KISIphoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen]bounds].size.width
#define MAINSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define MAINSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define CAPTURE_SESSION_QUALITY 2   // 0:640*480 vertical, 1:640*480 horizontal 2:1280*720 vertical, 3:1280:720 horizontal 4:1280*720 horizontal at left-up corner

// iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// iPhoneXR
#define IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size): NO)

//iPhoneXs Max
#define IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//异性全面屏
#define   isFullScreen    (IPHONE_Xr || IPHONE_Xs_Max || iPhoneX)

#define  StatusBarHeight      (isFullScreen ? 44.f : 20.f)
#define kTabBarHeight         (isFullScreen ? (49.f+34.f) : 49.f)//83
#define StatusBarAndNavigationBarHeight  (isFullScreen ? 88.f : 64.f)
#define TabbarSafeBottomMargin         (isFullScreen ? 34.f : 0.f)

#endif /* CommonUtil_h */
