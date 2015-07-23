 //
//  AppSession.m
//  MakeAFuss
//
//  Created by Andrei Balasanu on 7/18/15.
//  Copyright (c) 2015 Softvision. All rights reserved.
//

#import "AppSession.h"
#import "Post.h"
#import "PostCategory.h"
#import "Comment.h"
#import <AFNetworking/AFNetworking.h>

static NSString * const FailMessage = @"Fail";

@interface AppSession ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSNumber *userID;

@end

@implementation AppSession

- (instancetype)initWithApiHost:(NSURL *)url {
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

+ (instancetype)defaultSession {
    static AppSession *defaultSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *urlString = @"http://192.168.57.155:8080/pulse/rest/";
        defaultSession = [[AppSession alloc] initWithApiHost:[NSURL URLWithString:urlString]];
    });
    return defaultSession;
}

- (void)registerUser:(NSString *)name password:(NSString *)password completion:(void (^)(BOOL success))completion {
    NSString *path = [NSString stringWithFormat:@"authenticate/register/%@/%@",name, password];

    [self.sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject[@"errorMessage"] == [NSNull null]) {
            self.userID = responseObject[@"userId"];
            completion(YES);
        } else {
            completion(NO);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(NO);
    }];
}

- (void)loginUser:(NSString *)name password:(NSString *)password completion:(void (^)(BOOL success))completion {
    NSString *path = [NSString stringWithFormat:@"authenticate/login/%@/%@",name, password];

    [self.sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject[@"errorMessage"] == [NSNull null]) {
            self.userID = responseObject[@"userId"];
            completion(YES);
        } else {
            completion(NO);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(NO);
    }];
}

- (void)addPostWithTitle:(NSString *)title content:(NSString *)content categoryId:(NSInteger)categoryId anonymous:(BOOL)anonymous completion:(void (^)(BOOL success))completion {
    NSDictionary *params = @{ @"title": title, @"userId": self.userID, @"categoryId": @(categoryId), @"anonymous": @(anonymous), @"content": content };
    [self.sessionManager POST:@"posts/addPost" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) completion(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) completion(NO);
    }];
}

- (void)addRating:(float)rating toPost:(Post *)post completion:(void (^)(BOOL success))completion{
    NSString *path = [NSString stringWithFormat: @"posts/addPostRating/%@/%@/%@",post.postID, self.userID, @(rating)];
    
    [self.sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) completion(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) completion(NO);
    }];
}
- (void)fetchPostsWithType:(PostType)type category:(PostCategory *)category completion:(void (^)(NSArray *categories))completion {
    NSString *typeEndpoint = @"getRecent";
    if (type == PostTypePopular) {
        typeEndpoint = @"getPopular";
    } else if (type == PostTypeTopRated) {
        typeEndpoint = @"getTopRated";
    }
    
    NSInteger categoryId = category ? [category.categoryID integerValue] : 0;
    NSString *path = [NSString stringWithFormat:@"posts/%@/%@", typeEndpoint, @(categoryId)];
    [self.sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *posts = [NSMutableArray arrayWithCapacity:[responseObject count]];
        for (NSDictionary *dict in responseObject) {
            [posts addObject:[Post postWithDictionary:dict]];
        }
        if (completion) completion(posts);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) completion(nil);
    }];
}

- (void)addComment:(NSString *)commentText toPost:(Post *)post anonymous:(BOOL)anonymous completion:(void (^)(BOOL success))completion {
    NSDictionary *params = @{ @"postId": post.postID, @"userId": self.userID, @"anonymous": @(anonymous), @"content": commentText };

    [self.sessionManager POST:@"posts/addComment" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        if (completion) completion(YES);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) completion(NO);
    }];
}

- (void)fetchCategories:(void (^)(NSArray *categories))completion {
    [self.sessionManager GET:@"categories/getCategories" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *categories = [NSMutableArray arrayWithCapacity:[responseObject count]];
        for (NSDictionary *dict in responseObject) {
            [categories addObject:[PostCategory categoryWithDictionary:dict]];
        }
        completion(categories);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil);
    }];
}

- (void)fetchCommentsForPost:(Post *)post completion:(void (^)(NSArray *comments))completion {
    NSString *path = [NSString stringWithFormat:@"comments/%@", post.postID];
    
    [self.sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *comments = [NSMutableArray arrayWithCapacity:[responseObject count]];
        for (NSDictionary *dict in responseObject) {
            [comments addObject:[Comment commentWithDictionary:dict]];
        }
        completion(comments);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil);
    }];
}


@end
