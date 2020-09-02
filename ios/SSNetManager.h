//
//  SSNetManager.h
//  TestAFNetWorking
//
//  Created by shj on 2018/6/10.
//  Copyright © 2018年 shj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSNetManager : NSObject
+ (instancetype)instance;

- (void)request:(NSString *)urlString
         params:(NSDictionary *)params
    resultBlock:(void (^)(NSDictionary *))resultBlock;

- (void)downloadFile:(NSURL *)url
            progress:(void (^)(float progress))progressBlock
            complete:(void (^)(void))completeBlock;

- (void)uploadFile:(NSURL *)url
              data:(NSData *)data
          progress:(void (^)(float progress))progressBlock
          complete:(void (^)(void))completeBlock ;
@end
