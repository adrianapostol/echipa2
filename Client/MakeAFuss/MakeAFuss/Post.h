//
//  Post.h
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) float rating;
@property (nonatomic, strong) NSString *user;

- (instancetype)initWithPostID:(NSString *)postID title:(NSString *)title content:(NSString *)content category:(NSString *)category date:(NSDate *)date active:(BOOL)active rating:(float)rating user:(NSString *)user;

+ (instancetype)postWithDictionary:(NSDictionary *)dictionary;

@end
