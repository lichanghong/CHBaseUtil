//
//  CHUserDefaults+Properties.h
//

/**
 *  自定义的userdefaults 为了防止系统的NSUserDefaults内容过于繁杂
 *  用法是直接用单利，然后存取的key和value，直接用property设置即可
 
 
 *  [[NSUserDefaults standardUserDefaults] setObject:@"AAA" forKey:@"username"];
 [[NSUserDefaults standardUserDefaults] synchronize];  --> 系统用法
 
 *  [CHUserDefaults standardUserDefaults].username = @"AAA"; --> 当前用法
 
 * NSString * username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"] --> 系统用法
 
 * NSString * username = [CHUserDefaults standardUserDefaults].username; -->当前用法
 
 * 需要的key直接在当前添加property即可
 *
 */

#import "CHUserDefaults.h"

@interface CHUserDefaults(Properties)
//  
///** 用户第三方地图选择 */
//@property (nonatomic, copy) NSString *selectedMapScheme;
//
//#pragma mark - maidian
//@property (nonatomic, assign) NSInteger needRequestMaiDianCount;
//#pragma mark - end
//@property (nonatomic, assign) BOOL surgicalCareIsThisMonth;
//
////术后弹窗本地记录
//@property (nonatomic, copy) NSDictionary * surgicalCarePopUpWindows;
//@property (nonatomic, assign) BOOL hasCloseHongBao;//是否关闭了红包
@end
