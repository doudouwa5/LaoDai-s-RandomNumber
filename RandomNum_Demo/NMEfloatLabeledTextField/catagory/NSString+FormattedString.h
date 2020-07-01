//
//  NSString+NMEFormattedString.h
//  NearMerchant
//
//  Created by 韩豆豆 on 2019/8/2.
//  Copyright © 2019年 qmm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NMEfloatLabeledTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (NMEFormattedString)

//字符串转格式化字符串  0101010101  --->  010 101 0101
-(NSString *) toFormattedStringType:(NMEFloatFieldInputType )type;

//格式化字符串转元字符串  0101010101  --->  010 101 0101
-(NSString *) toOriginalString;

@end

NS_ASSUME_NONNULL_END
