//
//  JKDBModel.m
//
//  Created by lichanghong on 7/13/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "JKDBModel.h"
#import "JKDBHelper.h"

@implementation JKDBModel (JKDBModel)

/** 查询数据条数 */
+ (NSInteger)getAllRowCount
{
    JKDBHelper *jkDB = [JKDBHelper shareInstance];
    __block NSInteger count =0;
    [jkDB.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *tableName = NSStringFromClass(self.class);
        NSString *sql = [NSString stringWithFormat:@"SELECT count(pk) FROM %@",tableName];
        FMResultSet *resultSet = [db executeQuery:sql];
        if ([resultSet next]) {
            count = [resultSet intForColumnIndex:0];
        }
    }];
    return count;
}

@end
