//
//  Post.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "Post.h"

@implementation Post

- (instancetype)initWithPostID:(NSString *)postID title:(NSString *)title content:(NSString *)content category:(NSString *)category date:(NSDate *)date active:(BOOL)active rating:(float)rating user:(NSString *)user {
    
    self = [super init];
    
    if (self) {
        _postID = postID;
        _title = title;
        _content = content;
        _category = category;
        _date = date;
        _active = active;
        _rating = rating;
        _user = user;
    }
    return self;
}

+ (instancetype)postWithDictionary:(NSDictionary *)dictionary {
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
    }
    NSDate *postDate = [formatter dateFromString:dictionary[@"timestamp"]];
    
    return [[Post alloc] initWithPostID:dictionary[@"postID"]
                                  title:dictionary[@"title"]
                                content:dictionary[@"content"]
                               category:dictionary[@"category"]
                                   date:postDate
                                 active:[dictionary[@"active"] boolValue]
                                 rating:[dictionary[@"rating"] doubleValue]
                                   user:dictionary[@"user"]];
}

@end
