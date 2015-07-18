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
@property (nonatomic, strong) NSString *userID;

@end

@implementation AppSession

- (instancetype)initWithApiHost:(NSURL *)url {
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
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
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];

//    [self.sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, NSString* responseObject) {
//        
////        if ([responseObject isEqualToString:FailMessage]) {
////            completion(NO);
////        } else {
////            completion(YES);
////            self.userID = responseObject;
////        }
//        completion(YES);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        completion(NO);
//    }];
    completion(YES);
}

- (void)loginUser:(NSString *)name password:(NSString *)password completion:(void (^)(BOOL success))completion {
    NSString *path = [NSString stringWithFormat:@"authenticate/login/%@/%@",name, password];
    _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [self.sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, NSString* responseObject) {
//        if ([responseObject isEqualToString:FailMessage]) {
//            completion(NO);
//        } else {
//            completion(YES);
//            self.userID = responseObject;
//        }
//        completion(YES);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        completion(NO);
//    }];
    completion(YES);
}

- (void)fetchPostsWithParams:(NSDictionary *)postsParams completion:(void (^)(NSArray *posts))completion {
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *path = [NSString stringWithFormat:@"posts/getPopular/2"];
    
    completion([[self class] createPosts]);
    
//    [self.sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSMutableArray *posts = [NSMutableArray arrayWithCapacity:[responseObject count]];
//        for (NSDictionary *dict in responseObject) {
//            [posts addObject:[Post postWithDictionary:dict]];
//        }
//        completion(posts);
//     
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        completion(nil);
//    }];
}

- (void)fetchCategories:(void (^)(NSArray *categories))completion {
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];

    [self.sessionManager GET:@"categories" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *path = [NSString stringWithFormat:@"comments/%@", post.postID];
    
//    [self.sessionManager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSMutableArray *comments = [NSMutableArray arrayWithCapacity:[responseObject count]];
//        for (NSDictionary *dict in responseObject) {
//            [comments addObject:[Comment commentWithDictionary:dict]];
//        }
//        completion(comments);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        completion(nil);
//    }];
    completion([[self class] createComments]);
}

- (void)addPost:(NSDictionary *)post completion:(void (^)(BOOL success))completion {
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *path = [NSString stringWithFormat:@"posts/%@/1/%@/%@/", post[@"title"], post[@"content"], post[@"category"], self.userID];

    [self.sessionManager POST:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isEqualToString:FailMessage]) {
            completion(NO);
        } else {
            completion(YES);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(NO);
    }];
}

#pragma mark - Hardcodes

+ (NSArray *)createPosts {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:20];
    static NSInteger var = 0;
    var = (var + 1) % 2;
    NSString *title = var ? @"Hackthon" : @"Cherry Day";
    NSString *user = var ? @"Andrei C" : @"Codruta S";
    
    for (int idx = 0; idx < 20; idx++) {
        [array addObject:[[Post alloc] initWithPostID:@"1" title:title content:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris" category:@"Other" date:[NSDate date] active:YES rating:5.0 user:user]];
    }
    
    return array;
}

+ (NSArray *)createComments {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:20];
    
    for (int idx = 0; idx < 20; idx++) {
        [array addObject:[[Comment alloc] initWithID:@"ID" text:@"This is the best comment ever. You can't write one better." user:@"iCeq"]];
    }
    
    return array;
}

@end
