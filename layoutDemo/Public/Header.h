//
//  Header.h
//  ScrollDemo
//
//  Created by rp.wang on 16/9/20.
//  Copyright © 2016年 rp.wang. All rights reserved.
//

#ifndef Header_h
#define Header_h

/**
 *  apple公开接口
 */
#define APPLE_SERVER @"https://itunes.apple.com/search?term=game&country=cn&entity=software"
/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *  主屏的size
 */
#define DEF_SCREEN_SIZE   [[UIScreen mainScreen] bounds].size

/**
 *  主屏的frame
 */
#define DEF_SCREEN_FRAME  [UIScreen mainScreen].applicationFrame
/**
 *  主题颜色
 */
#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]
#endif /* Header_h */
