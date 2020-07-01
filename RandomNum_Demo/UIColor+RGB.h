//
//  UIColor+RGB.h
//  LvRen
//
//  Created by zuibaxian on 13-9-11.
//
//

#import <UIKit/UIKit.h>

@interface UIColor(RGB)
+(UIColor*)colorWithRGB:(UInt32)rgb;
+(UIColor*)colorWithRGB:(UInt32)rgb alpha:(CGFloat)alpha;
+(UInt32)rgbWithColor:(UIColor *)color;

+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;
+ (UIColor *) colorWithHexString: (NSString *) hexString;

/**
 *  UIColor生成UIImage
 *
 *  @param color     生成的颜色
 *  @param imageSize 生成的图片大小
 *
 *  @return 生成后的图片
 */
+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)imageSize;

+ (UIImage*)mixImages:(NSArray*)images;

@end
