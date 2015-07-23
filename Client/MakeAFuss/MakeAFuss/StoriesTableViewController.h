//
//  StoriesTableViewController.h
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSession.h"
#import "PostCategory.h"

typedef NS_ENUM(NSUInteger, StoryChannelType) {
    StoryChannelTypeTopRated = PostTypeTopRated,
    StoryChannelTypePopular = PostTypePopular,
    StoryChannelTypeRecent = PostTypeRecent
};

@interface StoriesTableViewController : UITableViewController

@property (nonatomic, copy) PostCategory *postCategory;

- (void)updateStoriesForChannelType:(StoryChannelType)channelType;
- (void)updateStoriesForQuery:(NSString *)query;

@end
