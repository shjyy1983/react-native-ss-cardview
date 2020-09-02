//
//  SSNetManager.m
//  TestAFNetWorking
//
//  Created by shj on 2018/6/10.
//  Copyright © 2018年 shj. All rights reserved.
//

#import "SSNetManager.h"
#import <AFNetworking/AFNetworking.h>

@interface SSNetManager()
@property (strong, nonatomic) AFURLSessionManager *sessionManager;
@end

@implementation SSNetManager

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static SSNetManager *obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [[SSNetManager alloc] init];
    });
    return obj;
}

- (void)request:(NSString *)urlString params:(NSDictionary *)params resultBlock:(void (^)(NSDictionary *))resultBlock {
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:params error:nil];
    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        resultBlock(responseObject);
    }];
    [task resume];
}

- (void)downloadFile:(NSURL *)url
            progress:(void (^)(float progress))progressBlock
            complete:(void (^)(void))completeBlock {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *downloadTask = [self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        progressBlock(downloadProgress.fractionCompleted);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载的路径设置
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *destinationRUL = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        NSLog(@"%@", destinationRUL.absoluteString);
        return destinationRUL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completeBlock();
    }];
    [downloadTask resume];
}

- (void)uploadFile:(NSURL *)url
          data:(NSData *)data
          progress:(void (^)(float progress))progressBlock
          complete:(void (^)(void))completeBlock {
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url.absoluteString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"filename.png" mimeType:@"image/jpeg"];
    } error:nil];
    
    NSURLSessionUploadTask *uploadTask = [self.sessionManager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            progressBlock(uploadProgress.fractionCompleted);
        });
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}


#pragma mark - Object

- (AFURLSessionManager *)sessionManager {
    if (_sessionManager) {
        return _sessionManager;
    }
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    return _sessionManager;
}

@end















