//
//  NSDictionary+CHRouter.h
//  ProjectDemo
//
//  Created by lichanghong on 5/4/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHRouter.h"

CG_EXTERN NSString *const CHRouterTransitionTypeKey; //转场动画
CG_EXTERN NSString *const CBRouterTransitionAnimatedKey; //是否动画转场

typedef NS_ENUM(NSInteger, CHRouterVCTransitionType) {
    CHRouterVCTransitionTypeUnknown,    // 未知
    CHRouterVCTransitionTypePush,       // push
    CHRouterVCTransitionTypePresent     // present
};

@interface NSDictionary (CHRouter)
- (CHRouterVCTransitionType)transitionType;

@end
