//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <OBJC/runtime.h>
#import "NSObject+CDFAssociatedWeakObject.h"

@interface CHAssociatedWeakObject : NSObject
@property (nonatomic, weak) id weakObject;
+ (instancetype)objectWithWeakObject:(id)weakObject;
@end

@implementation CHAssociatedWeakObject
+ (instancetype)objectWithWeakObject:(id)weakObject
{
    CHAssociatedWeakObject *obj = [[self alloc] init];
    obj.weakObject = weakObject;
    return obj;
}
@end



@implementation NSObject (CHAssociatedWeakObject)

- (void)setAssociatedWeakObject:(id)obj forKey:(const char *)key
{
    objc_setAssociatedObject(self, key, [CHAssociatedWeakObject objectWithWeakObject:obj], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedWeakObjectForKey:(const char *)key
{
    
    CHAssociatedWeakObject *obj = objc_getAssociatedObject(self, key);
    if (obj) {
        return obj.weakObject;
    } else {
        return nil;
    }
    
}
@end
