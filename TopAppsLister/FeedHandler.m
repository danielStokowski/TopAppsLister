//
//  FeedHandler.m
//  TopAppsLister
//
//  Created by Daniel Stokowski on 22.04.2014.
//  Copyright (c) 2014 BLTest. All rights reserved.
//

#import "FeedHandler.h"


NSString * const ITUNES_APPLICATIONS_ARRAY = @"feed.entry";
NSString * const FEED_URL = @"https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json";
@implementation FeedHandler

+ (NSURL*) urlForSmallImageForApplicationWithDictionary:(NSDictionary*) appDictionary{
    return [NSURL URLWithString:[[[appDictionary valueForKey:@"im:image"] firstObject] valueForKey: @"label"]];
}

@end
