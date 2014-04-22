//
//  FeedHandler.h
//  TopAppsLister
//
//  Created by Daniel Stokowski on 22.04.2014.
//  Copyright (c) 2014 BLTest. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const ITUNES_APPLICATIONS_ARRAY;
extern NSString * const FEED_URL;
@interface FeedHandler : NSObject

+ (NSURL*) urlForSmallImageForApplicationWithDictionary:(NSDictionary*) appDictionary;
    
@end
