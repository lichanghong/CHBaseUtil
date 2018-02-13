//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <OBJC/runtime.h>
#import "NSObject+CDFAssociatedWeakObject.h"

@interface CDFAssociatedWeakObject : NSObject
@property (nonatomic, weak) id weakObject;
+ (instancetype)objectWithWeakObject:(id)weakObject;
@end

@implementation CDFAssociatedWeakObject
+ (instancetype)objectWithWeakObject:(id)weakObject
{
    CDFAssociatedWeakObject *obj = [[self alloc] init];
    obj.weakObject = weakObject;
    return obj;
}
@end



@implementation NSObject (CDFAssociatedWeakObject)

- (void)setAssociatedWeakObject:(id)obj forKey:(const char *)key
{
    objc_setAssociatedObject(self, key, [CDFAssociatedWeakObject objectWithWeakObject:obj], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedWeakObjectForKey:(const char *)key
{
    
    CDFAssociatedWeakObject *obj = objc_getAssociatedObject(self, key);
    if (obj) {
        return obj.weakObject;
    } else {
        return nil;
    }
    
}
@end
