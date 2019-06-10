//
//  NSFileManager+Util.m
//  Catalog
//
//  Created by lichanghong on 15/03/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "NSFileManager+Util.h"

#define prefix_of_filemanager @"jfslkjsaklfhsdklfghgfhfdsjlkghfd"

@implementation NSFileManager(Util)

+ (NSString *)filePath:(NSString *)name Directory:(Directory)dir
{
    return [self filePathForKey:name Directory:dir];
}

//Document
+ (NSString *)getDocumentFilePath:(NSString*)strName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",prefix_of_filemanager,strName];
        return [documentsDirectory stringByAppendingPathComponent:name];
    }
    return documentsDirectory;
}

//Library & Library/Caches
+ (NSString *)getLibraryFilePath:(NSString *)strName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *library = [paths objectAtIndex:0];
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",prefix_of_filemanager,strName];
        return [library stringByAppendingPathComponent:name];
    }
    return library;
}

+ (NSString *)getLibraryCacheFilePath:(NSString *)strName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cache = [paths objectAtIndex:0];
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",prefix_of_filemanager,strName];
        return [cache stringByAppendingPathComponent:name];
    }
    return cache;
}


//tmp & subTmp
+ (NSString *)getTmpFilePath:(NSString *)strName {
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",prefix_of_filemanager,strName];
        return [NSTemporaryDirectory() stringByAppendingPathComponent:name];
    }
    return NSTemporaryDirectory();
}

//tmp & subTmp
+ (NSString *)getDefaultFilePath:(NSString *)strName {
    NSString *temp = NSTemporaryDirectory();
    NSString *subDir  = [temp stringByAppendingPathComponent:@"defaultFiles"];
    if (strName) {
        NSString *name = [NSString stringWithFormat:@"%@_%@",prefix_of_filemanager,strName];
        return [subDir stringByAppendingPathComponent:name];
    }
    return subDir;
}

+ (NSString *)filePathForKey:(NSString *)name Directory:(Directory)dirType
{
    NSString *filePath = nil;
    switch (dirType) {
        case  Directory_Documents:
            filePath = [self getDocumentFilePath:name];
            break;
        case Directory_Library:
            filePath = [self getLibraryFilePath:name];
            break;
        case Directory_LibraryCaches:
            filePath = [self getLibraryCacheFilePath:name];
            break;
        case Directory_tmp:
            filePath = [self getTmpFilePath:name];
            break;
        case Directory_default:
        {
            filePath = [self getDefaultFilePath:name];
        }
            break;
        default:
            break;
    }
    return filePath;
}

+ (BOOL)setObject:(id)object forKey:(NSString *)name Directory:(Directory)dirType
{
    if (object && name && [name isKindOfClass:[NSString class]])
    {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSString *filedir = [self filePathForKey:nil Directory:dirType]; //先检查目录是否存在?:创建目录，最后创建文件
        BOOL isDir = NO;
        BOOL existed = [fileManager fileExistsAtPath:filedir isDirectory:&isDir];
        if ( !(isDir == YES && existed == YES) ) {
            [fileManager createDirectoryAtPath:filedir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *real = [NSString stringWithFormat:@"%@_%@",prefix_of_filemanager,name];
        NSString *filePath = [filedir stringByAppendingPathComponent:real];
        NSData *saveSource = [NSKeyedArchiver archivedDataWithRootObject:object];
        return [fileManager createFileAtPath:filePath contents:saveSource attributes:nil];
    }
    return NO;
}

+ (BOOL)setObject:(id)object forKey:(NSString *)name
{
    return [self setObject:object forKey:name Directory:Directory_default];
}

+ (id)objectForKey:(NSString *)name
{
    return [self objectForKey:name Directory:Directory_default];
}

+ (id)objectForKey:(NSString *)name Directory:(Directory)dir
{
    if (name && [name isKindOfClass:[NSString class]])
    {
        NSString *filePath = [self filePathForKey:name Directory:dir];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSData *dataSource = [fileManager contentsAtPath:filePath];
        if (dataSource)
        {
            return [NSKeyedUnarchiver unarchiveObjectWithData:dataSource];
        }
    }
    return nil;
}

// remove
+ (BOOL)removeObjectForKey:(NSString *)name Directory:(Directory)dir
{
    if (name && [name isKindOfClass:[NSString class]])
    {
        NSString *filePath = [self filePathForKey:name Directory:dir];
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    
    return NO;
}

+ (BOOL)removeObjectForKey:(NSString *)name
{
    return [self removeObjectForKey:name Directory:Directory_default];
}

+ (void)removeDirectory:(Directory)dir
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *folderPath = [self filePathForKey:nil Directory:dir];
    NSArray *arr = [fileManager contentsOfDirectoryAtPath:folderPath error:nil];
    for (NSString *file in arr) {
        if ([file hasPrefix:prefix_of_filemanager]) {
            NSError *err;
            NSString *removePath = [folderPath stringByAppendingPathComponent:file];
           [fileManager removeItemAtPath:removePath error:&err];
        }
    }
}

+ (void)clearAllData
{
    [self removeDirectory:Directory_default];
    [self removeDirectory:Directory_Documents];
    [self removeDirectory:Directory_Library];
    [self removeDirectory:Directory_LibraryCaches];
    [self removeDirectory:Directory_tmp];
}

@end
