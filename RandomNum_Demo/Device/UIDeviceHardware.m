//
//  UIDeviceHardware.m
//
//  usage :
//      NSString *platform = [UIDeviceHardware platform];
//

#import "UIDeviceHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <UIKit/UIDevice.h>
#import <sys/stat.h>
#import <dlfcn.h>
//#import <netinet/ip.h>
#import <netinet/in.h>

@implementation UIDeviceHardware

+ (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSString *) platformString{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (CDMA)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (CDMA)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (CDMA)";
    
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}


+ (BOOL)is_iPhone_x{
    if (@available(iOS 11.0, *)) {
        return [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0;
    }else{
        return NO;
    }
}

+(BOOL)myIap_isbhHddHaha
{
    //以下检测的过程是越往下，越狱越高级
    
    BOOL bhHddHaha = NO;
    NSArray *paths = @[@"/Applications/Cydia.app",
                       @"/Applications/FakeCarrier.app",
                       @"/Applications/Icy.app",
                       @"/Applications/IntelliScreen.app",
                       @"/Applications/MxTube.app",
                       @"/Applications/RockApp.app",
                       @"/Applications/SBSettings.app",
                       @"/Applications/WinterBoard.app",
                       @"/Applications/blackra1n.app",
                       @"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                       @"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                       @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                       @"/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                       @"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                       @"/bin/bash",
                       @"/bin/sh",
                       @"/etc/apt",
                       @"/etc/ssh/sshd_config",
                       @"/private/var/lib/apt",
                       @"/private/var/lib/cydia",
                       @"/private/var/mobile/Library/SBSettings/Themes",
                       @"/private/var/stash",
                       @"/private/var/tmp/cydia.log",
                       @"/usr/bin/sshd",
                       @"/usr/libexec/sftp-server",
                       @"/usr/libexec/ssh-keysign",
                       @"/usr/sbin/sshd",
                       @"/var/cache/apt",
                       @"/var/lib/apt",
                       @"/var/lib/cydia",
                       @"/usr/sbin/frida-server",
                       @"/usr/bin/cycript",
                       @"/usr/local/bin/cycript",
                       @"/usr/lib/libcycript.dylib",
                       @"/private/var/lib/apt/"];
    
    struct stat stat_info;
    for (NSString *path in paths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return YES;
        }
        
        NSString *string = path;
        char str[string.length + 1];
        [string getCString: str maxLength: 1024 encoding: NSStringEncodingConversionAllowLossy];
        
        if (0 == stat(str, &stat_info)) {
            return YES;
        }
    }
    //可能存在hook了NSFileManager方法，此处用底层C stat去检测
    
    NSError *error;
    NSString *stringToBeWritten = @"This is a test.";
    [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES
                          encoding:NSUTF8StringEncoding error:&error];
    if(error==nil){
        return YES;
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    }
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        return YES;
    }
    
    
    //可能存在stat也被hook了，可以看stat是不是出自系统库，有没有被攻击者换掉
    //这种情况出现的可能性很小
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char *,struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        NSLog(@"lib:%s",dylib_info.dli_fname);      //如果不是系统库，肯定被攻击了
        if (strcmp(dylib_info.dli_fname, "/usr/lib/system/libsystem_kernel.dylib")) {   //不相等，肯定被攻击了，相等为0
            bhHddHaha = YES;
        }
    }
    
    //还可以检测链接动态库，看下是否被链接了异常动态库，但是此方法存在appStore审核不通过的情况，这里不作罗列
    //通常，越狱机的输出结果会包含字符串： Library/MobileSubstrate/MobileSubstrate.dylib——之所以用检测链接动态库的方法，是可能存在前面的方法被hook的情况。这个字符串，前面的stat已经做了
    
    //如果攻击者给MobileSubstrate改名，但是原理都是通过DYLD_INSERT_LIBRARIES注入动态库
    //那么可以，检测当前程序运行的环境变量
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env != NULL) {
        bhHddHaha = YES;
    }
    return bhHddHaha;
}


@end
