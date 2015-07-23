//
//  AppSession.h
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Post;
@class PostCategory;

typedef NS_ENUM(NSInteger, PostType) {
    PostTypeNone,
    PostTypeTopRated,
    PostTypePopular,
    PostTypeRecent
};


@interface AppSession : NSObject

+ (instancetype)defaultSession;

- (void)registerUser:(NSString *)name password:(NSString *)password completion:(void (^)(BOOL success))completion;
- (void)loginUser:(NSString *)name password:(NSString *)password completion:(void (^)(BOOL success))completion;
- (void)addPostWithTitle:(NSString *)title content:(NSString *)content categoryId:(NSInteger)categoryId anonymous:(BOOL)anonymous completion:(void (^)(BOOL success))completion;
- (void)addRating:(float)rating toPost:(Post *)post completion:(void (^)(BOOL success))completion;
- (void)fetchPostsWithType:(PostType)type category:(PostCategory *)category completion:(void (^)(NSArray *categories))completion;
- (void)addComment:(NSString *)commentText toPost:(Post *)post anonymous:(BOOL)anonymous completion:(void (^)(BOOL success))completion;
- (void)fetchCategories:(void (^)(NSArray *categories))completion;
- (void)fetchCommentsForPost:(Post *)post completion:(void (^)(NSArray *comments))completion;

@end
