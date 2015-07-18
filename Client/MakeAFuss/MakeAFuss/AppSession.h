//
//  AppSession.h
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Post;
@interface AppSession : NSObject

+ (instancetype)defaultSession;

- (void)registerUser:(NSString *)name password:(NSString *)password completion:(void (^)(BOOL success))completion;
- (void)loginUser:(NSString *)name password:(NSString *)password completion:(void (^)(BOOL success))completion;
- (void)fetchPostsWithParams:(NSDictionary *)postsParams completion:(void (^)(NSArray *posts))completion;
- (void)fetchCategories:(void (^)(NSArray *categories))completion;
- (void)fetchCommentsForPost:(Post *)post completion:(void (^)(NSArray *comments))completion;
- (void)addPost:(NSDictionary *)post completion:(void (^)(BOOL success))completion;

@end
