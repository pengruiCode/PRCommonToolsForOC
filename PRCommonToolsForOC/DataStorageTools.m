//
//  DataStorageTools.m
//  CommunityPeople
//
//  Created by 彭睿 on 2019/7/22.
//  Copyright © 2019 彭睿. All rights reserved.
//

#import "DataStorageTools.h"
#import "StaticStringTools.h"
#import <SDWebImage/SDImageCache.h>

@implementation DataStorageTools


+ (void)setObject:(id)object forKey:(NSString *)key {
     [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
}

+ (id)objectForKey:(NSString *)key {
    
    if (key == kCityName && ![[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return STATIC_DEFAULT_CITYNAME;
    }
    
    if (key == kCityCode && ![[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return STATIC_DEFAULT_CITYCODE;
    }
    
    if (key == kLatitude && ![[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return STATIC_DEFAULT_LATITUDE;
    }
    
    if (key == kLongitude && ![[NSUserDefaults standardUserDefaults] objectForKey:key]) {
        return STATIC_DEFAULT_LONITUDE;
    }
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


+ (void)setObjectToArchiver:(id)object forPath:(NSString *)path {
    [NSKeyedArchiver  archiveRootObject:object toFile:[DataStorageTools dataPath:path]];
}


+ (id)objectForPath:(NSString *)path {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[DataStorageTools dataPath:path]];
}


+ (NSString *)dataPath:(NSString *)file
{
    NSString *path = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"UserDataFiles"]stringByAppendingPathComponent:file];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    NSString *result = [path stringByAppendingPathComponent:@".data"];
    return result;
}


+ (void)loginQuitRemoveData {
    [DataStorageTools clearCache];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserRefreshToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserPhone];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserIcon];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserNGCCircleId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserRegisterTime];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kJPushRegisterId];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWXNickName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWXIcon];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAddressLinkmanName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAddressLinkmanMobi];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSearchHistory];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kShopingCartSelectShopArr];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kShopingCartSelectGoodsArr];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kWiFiClientMac];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCardIdForSelect];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KCityCodeSelect];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCityNameSelect];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLatitudeSelect];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLongitudeSelect];
}


+ (void)clearCache {
    [[SDImageCache sharedImageCache] clearMemory];
    [DataStorageTools clearFile];
}


+ (void)clearFile {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    //NSLog ( @"cachpath = %@" , cachePath);
    
    //读取缓存大小
    float cacheSize = [DataStorageTools readCacheSize] ;
    NSLog(@"缓存大小:%f",cacheSize);
    //    [NSString stringWithFormat:@"%.2fKB",cacheSize];
    
    for (NSString *p in files) {
        NSError *error = nil;
        //获取文件全路径
        NSString *fileAbsolutePath = [cachePath stringByAppendingPathComponent:p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileAbsolutePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:fileAbsolutePath error:&error];
        }
    }
    
    NSString *documentsPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"UserDataFiles"];
    [[NSFileManager defaultManager] removeItemAtPath:documentsPath error:nil];
}



+ (float)folderSizeAtPath:(NSString *)folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [DataStorageTools fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0 * 1024.0);
}


+ (long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error: nil] fileSize];
    }
    return 0;
}


+ (float)readCacheSize {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [DataStorageTools folderSizeAtPath :cachePath];
}


@end
