//
//  NSFileManager+Util.h
//  Catalog
//
//  Created by lichanghong on 15/03/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger,Directory) {
    Directory_default         = 0,      // Library/Caches/defaultFiles
    Directory_Documents       = 1,      // Documents       (理论上永不删除)
    Directory_Library         = 2,      // Library         (理论上永不删除)
    Directory_LibraryCaches   = 3,      // Library/Caches
    Directory_tmp             = 6       // tmp
};


/***
 本地化数据，文件
 Directory:文件目录路径
 name:文件名称，同名name会覆盖,name即为文件名
 subDir:文件夹下子文件夹
 ***/
@interface NSFileManager(Util)

+ (BOOL)setObject:(id)object forKey:(NSString *)name;                              //defaultFiles
+ (BOOL)setObject:(id)object forKey:(NSString *)name Directory:(Directory)dirType; //保存某个数据

+ (id)objectForKey:(NSString *)name;//获取某个数据
+ (id)objectForKey:(NSString *)name Directory:(Directory)dir;//获取某个数据

+ (BOOL)removeObjectForKey:(NSString *)name;
+ (BOOL)removeObjectForKey:(NSString *)name Directory:(Directory)dir;//删除某个数据
+ (void)removeDirectory:(Directory)dir;//删除某个目录

+ (NSString *)filePath:(NSString *)name Directory:(Directory)dir;//获取文件路径

+ (void)clearAllData; //删除本类创建的所有数据

@end
