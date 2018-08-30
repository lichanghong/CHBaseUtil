/**
 * Copyright (c) 2016-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import <Foundation/Foundation.h>

//! Project version number for VZRetainCycleDetector.
FOUNDATION_EXPORT double VZRetainCycleDetectorVersionNumber;

//! Project version string for VZRetainCycleDetector.
FOUNDATION_EXPORT const unsigned char VZRetainCycleDetectorVersionString[];

#import "VZAssociationManager.h"
#import "VZObjectiveCBlock.h"
#import "VZObjectiveCGraphElement.h"
#import "VZObjectiveCNSCFTimer.h"
#import "VZObjectiveCObject.h"
#import "VZObjectGraphConfiguration.h"
#import "VZParsedStruct.h"
#import "VZParsedType.h"
#import "VZStandardGraphEdgeFilters.h"
#import "VZStructEncodingParser.h"

/**
 Retain Cycle Detector is enabled by default in DEBUG builds, but you can also force it in other builds by
 uncommenting the line below. Beware, Retain Cycle Detector uses some private APIs that shouldn't be compiled in
 production builds.
 */
//#define RETAIN_CYCLE_DETECTOR_ENABLED 1

/**
 VZRetainCycleDetector

 The main class responsible for detecting retain cycles.

 Be cautious, the class is NOT thread safe.

 The process of detecting retain cycles is relatively slow and consumes a lot of CPU.
 */

@interface VZRetainCycleDetector : NSObject

/**
 Designated initializer

 @param configuration Configuration for detector. Can include specific filters and options.
 @see VZRetainCycleDetectorConfiguration
 */
- (nonnull instancetype)initWithConfiguration:(nonnull VZObjectGraphConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

/**
 Adds candidate you are interested in getting retain cycles from.

 @param candidate Any Objective-C object you want to verify for cycles.
 */
- (void)addCandidate:(nonnull id)candidate;

/**
 Searches for all retain cycles for all candidates the detector has been
 provided with.

 @return NSSet with retain cycles. An element of this array will be
 an array representing retain cycle. That array will hold elements
 of type VZObjectiveCGraphElement.

 @discussion For given candidate, the detector will go through all object graph rooted in this candidate and return
 ALL retain cycles that this candidate references. It will also take care of removing duplicates. It will not look for
 cycles longer than 10 elements. If you want to look for longer ones use findRetainCyclesWithMaxCycleLenght:
 */
- (nonnull NSSet<NSArray<VZObjectiveCGraphElement *> *> *)findRetainCycles;

- (nonnull NSSet<NSArray<VZObjectiveCGraphElement *> *> *)findRetainCyclesWithMaxCycleLength:(NSUInteger)length;

/**
 This macro is used across VZRetainCycleDetector to compile out sensitive code.
 If you do not define it anywhere, Retain Cycle Detector will be available in DEBUG builds.
 */
#ifdef RETAIN_CYCLE_DETECTOR_ENABLED
#define _INTERNAL_RCD_ENABLED RETAIN_CYCLE_DETECTOR_ENABLED
#else
#define _INTERNAL_RCD_ENABLED DEBUG
#endif

@end
