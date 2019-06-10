//  Created by lichanghong on 9/9/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "NSDictionary+SafeAccess.h"
#import "NSObject+SafeSelection.h"

@implementation NSDictionary (SafeAccess)

+ (void)load {

#if DEBUG
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        @autoreleasepool
        {
            Class dictionaryM = objc_getClass("__NSDictionaryM");
            
            [dictionaryM classReplaceMethod:@selector(setObject:forKey:)
                                 hookMethod:@selector(hookM_setObject:forKey:)];
        }
    });
    
#endif

}

- (void)hookM_setObject:(id)anObject forKey:(id)aKey {
    
    if (anObject && aKey)
    {
        [self hookM_setObject:anObject forKey:aKey];
    }
    else
    {
        NSString *message = [NSString stringWithFormat:@"setObject:forKey: 不能设置nil"];
        
        [CHCrashManager showCrashMessage:NSStringFromClass(self.class) crashMethod:message];
    }
}

@end
