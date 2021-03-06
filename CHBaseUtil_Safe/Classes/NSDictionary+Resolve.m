//  Created by lichanghong on 9/9/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#include <objc/runtime.h>
#import "NSDictionary+Resolve.h"

@implementation NSDictionary (Resolve)

- (id)customForKey:(id)aKey {
    
    if (aKey)
    {
        id theObject = nil;
        
        @try
        {
            theObject = [self valueForKeyPath:aKey];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            if (theObject)
            {
                if ([theObject isKindOfClass:[NSNull class]])
                {
                    theObject = @"";
                }
                else if ([theObject isKindOfClass:[NSNumber class]])
                {
                    theObject = [theObject description];
                }
            }
            else
            {
                theObject = @"";
            }
            
            return theObject;
        }
    }
    
    return @"";
}

@end
