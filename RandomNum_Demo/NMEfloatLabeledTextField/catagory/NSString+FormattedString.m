//
//  NSString+NMEFormattedString.m
//  NearMerchant
//
//  Created by 韩豆豆 on 2019/8/2.
//  Copyright © 2019年 qmm. All rights reserved.
//

#define placeholderBlank @" "
#define placeholderLine @"-"


#import "NSString+FormattedString.h"

@implementation NSString (NMEFormattedString)


-(NSString *) toFormattedStringType:(NMEFloatFieldInputType )type{
    
    if (!self) {
        return nil;
    }
    
    NSMutableString* mStr;
    if(type == NMEFloatFieldInputTypeBankAccount){
        mStr = [NSMutableString stringWithString:[self stringByReplacingOccurrencesOfString:placeholderLine withString:@""]];
        if (mStr.length >3) {
            [mStr insertString:placeholderLine atIndex:3];
        }
        if (mStr.length > 5) {
            [mStr insertString:placeholderLine atIndex:5];
        }
    }else if(type == NMEFloatFieldInputTypePhoneNum){
        mStr = [NSMutableString stringWithString:[self stringByReplacingOccurrencesOfString:placeholderBlank withString:@""]];
        if (mStr.length > 3) {
            [mStr insertString:placeholderBlank atIndex:3];
        }
        if (mStr.length > 7) {
            [mStr insertString:placeholderBlank atIndex:7];
        }
    }else if(type == NMEFloatFieldInputTypeCitizenID){
        mStr = [NSMutableString stringWithString:[self stringByReplacingOccurrencesOfString:placeholderBlank withString:@""]];
        if (mStr.length > 1) {
            [mStr insertString:placeholderBlank atIndex:1];
        }
        if (mStr.length > 6) {
            [mStr insertString:placeholderBlank atIndex:6];
        }
        if (mStr.length > 12) {
            [mStr insertString:placeholderBlank atIndex:12];
        }
    }
    return mStr;
}


//格式化字符串转元字符串  0101010101  --->  010 101 0101
-(NSString *) toOriginalString{

    if (!self) {
        return @"";
    }
    NSString *mStr = self;
    mStr = [mStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    mStr = [mStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return mStr;
}

@end
