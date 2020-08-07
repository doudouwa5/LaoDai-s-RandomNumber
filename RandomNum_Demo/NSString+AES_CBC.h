//
//  NSString+AES_CBC.h
//  NearMerchant
//
//  Created by 韩豆豆 on 2020/1/14.
//  Copyright © 2020年 qmm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES_CBC)

#pragma -mark 默认的AES128加解密
/**< 加密方法
    默认key为:@"45A1FC1E60164AB5"
    偏移量为:@"0102030405060708"
 */
- (NSString*) encryptWithAES128DefaultKey;

/**< 解密方法 */
- (NSString*) decryptWithAES128DefaultKey;


#pragma -mark AES128加解密
/**< 加密方法 */
- (NSString*) encryptWithAES128WithKey: (NSString *)key;

/**< 解密方法 */
- (NSString*) decryptWithAES128WithKey: (NSString *)key;


#pragma -mark AES256加解密
/**< 加密方法 */
- (NSString*) encryptWithAES256WithKey: (NSString *)key;

/**< 解密方法 */
- (NSString*) decryptWithAES256WithKey: (NSString *)key;

@end

NS_ASSUME_NONNULL_END
