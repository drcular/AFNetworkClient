//
//  BMNetAPIClicnet.h
//  LPBM
//
//  Created by liyongwei on 15/9/23.
//  Copyright (c) 2015年 BM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef enum NetworkMethodType
{
    Get = 0,
    Post,
    Put,
    Delete
} NETWORK_METHOD_TYPE;

typedef void (^BMNetAPIResponceBlock)(id data ,NSError* error);

@interface BMNetAPIClient : AFHTTPSessionManager

+ (BMNetAPIClient *)sharedJsonClient;
+ (void)confifWithURLString:(NSString*)urlString;

/**
 *  NetWorking
 *
 *  @param aPath         接口路径
 *  @param params        接口所需要的参数
 *  @param NetworkMethod 请求类型
 *  @param isLoading     是否需要loading框
 *  @param block         返回数据和错误信息
 */
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NETWORK_METHOD_TYPE)NetworkMethod
                    withLoading:(BOOL)isLoading
                       andBlock:(BMNetAPIResponceBlock)block;

- (void)requestObjectWithPath:(NSString *)aPath
                   withParams:(NSDictionary*)params
             withObjectClassz:(Class)classz
               withMethodType:(NETWORK_METHOD_TYPE)NetworkMethod
                  withLoading:(BOOL)isLoading
                    withStore:(BOOL)isStore
                     andBlock:(BMNetAPIResponceBlock)block;
/**
 *  AFMultipartFormData 方式上传图片
 *
 *  @param aPath        接口路径
 *  @param params       接口所需要的参数
 *  @param name         图片名称不带后缀
 *  @param fileName     图片名称带后缀
 *  @param filePath_    图片物理路径
 *  @param NetworkMetho 请求类型
 *  @param block        返回数据或者错误信息
 */
-(void)requestImageDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                       WithName:(NSString *)name
                       fileName:(NSString *)fileName
                       filePath:(NSString *)filePath_
                 withMethodType:(int)NetworkMetho
                       andBlock:(BMNetAPIResponceBlock)block;

// 上传图片
-(void)requestImageDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                  withImageData:(NSData *)data
                  withFieldName:(NSString *)fieldName
               withObjectClassz:(Class)classz
                    withLoading:(BOOL)isLoading
                       andBlock:(BMNetAPIResponceBlock)block;

@end
