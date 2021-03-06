//
//  HDDColor.m
//  NearMerchant
//
//  Created by 韩豆豆 on 1/18/16.
//  Copyright © 2016 qmm. All rights reserved.
//

#import "HDDColor.h"
#import "UIColor+RGB.h"
@implementation HDDColor


+ (UIColor *)lightOrangeColor{
    return [UIColor colorWithHexString:@"#FFB256"];
//    return UIColorFromRGB(0xefa245);
}

+ (UIColor *)darkOrangeColor{
    return [UIColor colorWithHexString:@"#FF6E00"];
//    return UIColorFromRGB(0xe8580b);
}

+ (UIColor *)lightBlueColor{
    return [UIColor colorWithHexString:@"#2469CD"];
//    return UIColorFromRGB(0x1c4eff);
}

+ (UIColor *)darkBlueColor{
    return [UIColor colorWithHexString:@"#121670"];
//    return UIColorFromRGB(0x152c8e);
}

+ (UIColor *)blueColor{
    return [UIColor blueColor];
}

+ (UIColor *)commonLineColor{
    return [UIColor colorWithHexString:@"#DADAE0"];
}

+ (UIColor *)commonBgLightGrayColor{
    return [UIColor colorWithHexString:@"#F5F7F9"];
}

+ (UIColor *)commonTextGrayColor{
    return [UIColor colorWithHexString:@"#7B7F8A"];
}

+ (UIColor *)commonTextBlueColor{
    return [UIColor colorWithHexString:@"#003399"];
}

+ (UIColor *)redColor {
    return [UIColor colorWithRed:1.0 green:83 / 255.0 blue:89 / 255.0 alpha:1.0];
}

+ (UIColor *)hb_redColor {
    return [UIColor colorWithRed:240 / 255.0 green:79 / 255.0 blue:70 / 255.0 alpha:1.0];
}

+ (UIColor *)darkRedColor {
    return [UIColor colorWithRed:185 / 255.0 green:62 / 255.0 blue:55 / 255.0 alpha:1.0];
}

+ (UIColor *)whiteColor {
    return [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

+ (UIColor *)orangeColor {
    //return [UIColor colorWithRed:43.0 / 255.0 green:69.0 / 255.0 blue:150.0f / 255.0 alpha:1.0];
    return [self commonTextBlueColor];
}


+ (UIColor *)orangeColor_alpha {
    return [UIColor colorWithRed:33 / 255.0 green:150 / 255.0 blue:243 / 255.0f alpha:0.5];
}



+ (UIColor *)hb_orangeColor {
    return [UIColor colorWithRed:254 / 255.0 green:155 / 255.0 blue:32 / 255.0 alpha:1.0];
}

+ (UIColor *)grayColor {
    return [UIColor colorWithRed:167 / 255.0 green:169 / 255.0 blue:174 / 255.0 alpha:1.0];
}

+ (UIColor *)midGrayColor {
    return [UIColor colorWithRed:194 / 255.0 green:194 / 255.0 blue:194 / 255.0 alpha:1.0];
}

+ (UIColor *)blackColor {
    return [UIColor colorWithRed:47 / 255.0 green:50 / 255.0 blue:58 / 255.0 alpha:1.0];
}

+ (UIColor *)blackColorAlpha9 {
    return [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.9];
}

+ (UIColor *)midBlackColor {
    return [UIColor colorWithRed:78 / 255.0 green:80 / 255.0 blue:87 / 255.0 alpha:1.0];
}

+ (UIColor *)lightBlackColor {
    return [UIColor colorWithRed:96 /255.0 green:100 / 255.0 blue:112 / 255.0 alpha:1.0];
}

+ (UIColor *)bgColor {
    return [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0];
}

+ (UIColor *)hb_bgColor {
    return [UIColor colorWithRed:250 / 255.0 green:248 / 255.0 blue:246 / 255.0 alpha:1.0];
}

+ (UIColor *)lightGrayColor {
    return [UIColor colorWithRed:229 / 255.0 green:229 / 255.0 blue:229 / 255.0 alpha:1.0];
}

+ (UIColor *)ahtensGrayColor {
    return [UIColor colorWithRed:222 / 255.0 green:222 / 255.0 blue:222 / 255.0 alpha:1.0];
}

+ (UIColor *)primaryColor {
    return [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1.0];
}

+ (UIColor *)aluminiumColor {
    return [UIColor colorWithRed:138 / 255.0 green:140 / 255.0 blue:146 / 255.0 alpha:1.0];
}

+ (UIColor *)brownColor {
    return [UIColor colorWithRed:105 / 255.0 green:32 / 255.0 blue:25 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithE6E7E9 {
    return [UIColor colorWithRed:230 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith6ED61B {
    return [UIColor colorWithRed:110 / 255.0 green:214 / 255.0 blue:27 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith1EC622 {
    return [UIColor colorWithRed:30 / 255.0 green:198 / 255.0 blue:34 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithFFDCB1{
    return [UIColor colorWithRed:255 / 255.0 green:220 / 255.0 blue:177 / 255.0 alpha:1.0];
}

+ (UIColor *)backGroundColor {
    return [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0];
}

+ (UIColor *)athensGrayColor {
    return [UIColor colorWithRed:222 / 255.0 green:222 / 255.0 blue:222 / 255.0 alpha:1.0];
}

+ (UIColor *)lightGoldColor {
    return [UIColor colorWithRed:255 / 255.0 green:217 / 255.0 blue:138 / 255.0 alpha:1.0];
}

+ (UIColor *)darkPurpleColor {
    return [UIColor colorWithRed:55 / 255.0 green:40 / 255.0 blue:77 / 255.0 alpha:1.0];
}

+ (UIColor *)royalPurpleColor {
    return [UIColor colorWithRed:136 / 255.0 green:98 / 255.0 blue:233 / 255.0 alpha:1.0];
}

+ (UIColor *)lightPurpleColor {
    return [UIColor colorWithRed:191 / 255.0 green:167 / 255.0 blue:248 / 255.0 alpha:1.0];
}

+ (UIColor *)greenColor {
    return [UIColor colorWithRed:92 / 255.0 green:184 / 255.0 blue:13 / 255.0 alpha:1.0];
}

+ (UIColor *)mainThemeColor {
    return [UIColor colorWithHexString:@"0x2196f3"];
}

+ (UIColor *)ffd406Color {
    return [UIColor colorWithRed:255 / 255.0 green:212 / 255.0 blue:6 / 255.0 alpha:1.0];
}

+ (UIColor *)royalPurpleColorWithAlpha:(CGFloat)Alpha {
    return [UIColor colorWithRed:136 / 255.0 green:98 / 255.0 blue:233 / 255.0 alpha:Alpha];
}

+ (UIColor *)blackColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:alpha];
}

+ (UIColor *)acacacColor {
    return [UIColor colorWithRed:172 / 255.0 green:172 / 255.0 blue:172 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith70A3E1 {
    return [UIColor colorWithRed:112 / 255.0 green:162 / 255.0 blue:225 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith91BCF0 {
    return [UIColor colorWithRed:145 / 255.0 green:188 / 255.0 blue:240 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith7546DD {
    return [UIColor colorWithRed:117 /225.0 green:70 / 255.0 blue:221 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithFD5359 {
    return [UIColor colorWithRed:253 / 255.0 green:83 / 255.0 blue:89 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithFFD1D1 {
    return [UIColor colorWithRed:1.0 green:209 / 255.0 blue:209 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithFFE5D8 {
    return [UIColor colorWithRed:1.0 green:229 / 255.0 blue:216 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith8B62E9 {
    return [UIColor colorWithRed:139 / 255.0 green:98 / 255.0 blue:233 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithFF6282 {
    return [UIColor colorWithRed:1.0 green:98 / 255.0 blue:130 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith764DFF {
    return [UIColor colorWithRed:118 / 255.0 green:77 / 255.0 blue:1.0 alpha:1.0];
}

+ (UIColor *)colorWithFF7049 {
    return [UIColor colorWithRed:1.0 green:112 / 255.0 blue:73 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithFFF1DC {
    return [UIColor colorWithRed:1.0 green:241 / 255.0 blue:220 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithFFF5E3 {
    return [UIColor colorWithRed:1.0 green:245 / 255.0 blue:227 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith2D304D {
    return [UIColor colorWithRed:45 / 255.0 green:48 / 255.0 blue:77 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith8780F4 {
    return [UIColor colorWithRed:135 / 255.0 green:128 / 255.0 blue:244 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWith71D321 {
    return [UIColor colorWithRed:113 / 255.0 green:211 / 255.0 blue:33 / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithFF3D1F {
    return [UIColor colorWithRed:255 / 255.0 green:61 / 255.0 blue:31 / 255.0 alpha:1.0];
}

+ (UIColor*)colorWith181A1D {
    return [UIColor colorWithRed:24 / 255.0 green:26 / 255.0 blue:29 / 255.0 alpha:1.0];
}

+ (UIColor*)colorWith606470 {
    return [UIColor colorWithRed:60 / 255.0 green:64 / 255.0 blue:70 / 255.0 alpha:1.0];
}

+ (UIColor*)colorWith9D9FA4 {
    return [UIColor colorWithHexString:@"0x9D9FA4"];
}


@end
