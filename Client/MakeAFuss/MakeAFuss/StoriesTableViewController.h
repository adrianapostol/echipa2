//
//  StoriesTableViewController.h
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, StoryChannelType) {
    StoryChannelTypeTopRated,
    StoryChannelTypePopular,
    StoryChannelTypeRecent
};

@interface StoriesTableViewController : UITableViewController

@property (nonatomic, copy) NSString *storyCategory;

- (void)updateStoriesForChannelType:(StoryChannelType)channelType;
- (void)updateStoriesForQuery:(NSString *)query;

@end
