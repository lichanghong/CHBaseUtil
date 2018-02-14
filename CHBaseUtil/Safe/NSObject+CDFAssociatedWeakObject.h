//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <UIKit/UIKit.h>

@interface NSObject (CHAssociatedWeakObject)

- (void)setAssociatedWeakObject:(id)obj forKey:(const char *)key;

- (id)associatedWeakObjectForKey:(const char *)key;

@end
