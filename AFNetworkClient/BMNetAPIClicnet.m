//
//  BMNetAPIClicnet.m
//  LPBM
//
//  Created by liyongwei on 15/9/23.
//  Copyright (c) 2015年 BM. All rights reserved.
//

#import "BMNetAPIClicnet.h"
#import <CommonCrypto/CommonDigest.h>

#import "NSObject+AutoCoding.h"
#import "SVProgressHUD.h"

@interface BMNetAPIClient()
@end

@implementation BMNetAPIClient

static BMNetAPIClient *sharedObj = nil;
+ (BMNetAPIClient *)sharedJsonClient {
    if (!sharedObj) {
         NSLog(@"!!!confifWithURLString MUST call First!!!");
    }
    
    return sharedObj;
}
+ (void)confifWithURLString:(NSString*)urlString{
    
    if (!sharedObj) {
        sharedObj = [[BMNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
         NSLog(@"config URL SUCESS:%@",urlString);
    }else{
        
        if (![sharedObj.baseURL.absoluteString isEqualToString:urlString])
        {
            sharedObj = [[BMNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
            
            NSLog(@"UPDATE config URL is SUCESS:%@",urlString);
            
        }else{
            NSLog(@"UPDATE config URL is SAME:%@",urlString);
        }
    }
}
- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
 
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", @"text/javascript", @"text/json",nil];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.securityPolicy.allowInvalidCertificates = YES;
    self.requestSerializer.timeoutInterval = 10;
    
    return self;
}

-(void)popSVGAfter:(NSInteger)seconds{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [SVProgressHUD popActivity];
        
    });
}

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
                       andBlock:(BMNetAPIResponceBlock)block
{
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"\n===========request===========\n%@    \n%@ ", aPath, params);
    //是否需要loading加载框
    if(isLoading){
        //                [MBProgressHUD showMessage:DEF_ALERTMESSAGE toView:[[UIApplication sharedApplication].delegate window]];
    }
    //发起请求
    switch (NetworkMethod) {
        case Get:{
            [self GET:aPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil, error);
            }];
            //            [self GET:aPath parameters:params success:^(NSURLSessionDataTask  *task, id responseObject) {
            //                NSLog(@"\n===========responseObject===========\n aPath = %@:\n responseObject = %@ \n responseString = %@", aPath, responseObject);
            //                block(responseObject, nil);
            //            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //                NSLog(@"\n===========error===========\n aPath = %@:\n error = %@ \n errorResponseString = %@", aPath, error, operation.responseString);
            //                //                [MBProgressHUD showError:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            //                block(nil, error);
            //            }];
            break;
        }
        case Post:{
            [self POST:aPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil, error);
            }];
            //            [self POST:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
            //             {
            //                 //                 [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
            //                 NSLog(@"\n===========responseObject===========\n aPath = %@:\n responseObject = %@ \n responseString = %@", aPath, responseObject,operation.responseString);
            //                 block(responseObject, nil);
            //             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //                 //                 [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
            //                 NSLog(@"\n===========error===========\n aPath = %@:\n error = %@ \n errorResponseString = %@", aPath, error, operation.responseString);
            //                 //                 [MBProgressHUD showError:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            //                 block(nil, error);
            //             }];
            break;
        }
        case Put:{
            [self PUT:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil, error);
            }];
            //            [self PUT:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //                NSLog(@"\n===========responseObject===========\n aPath = %@:\n responseObject = %@ \n responseString = %@", aPath, responseObject,operation.responseString);
            //                block(responseObject, nil);
            //            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //                NSLog(@"\n===========error===========\n aPath = %@:\n error = %@ \n errorResponseString = %@", aPath, error, operation.responseString);
            //                //                [MBProgressHUD showError:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            //                block(nil, error);
            //            }];
            break;
        }
        case Delete:{
            [self DELETE:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil, error);
            }];
            
            //            [self DELETE:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //                NSLog(@"\n===========responseObject===========\n aPath = %@:\n responseObject = %@ \n responseString = %@", aPath, responseObject,operation.responseString);
            //                block(responseObject, nil);
            //            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //                NSLog(@"\n===========error===========\n aPath = %@:\n error = %@ \n errorResponseString = %@", aPath, error, operation.responseString);
            //                //                [MBProgressHUD showError:[error.userInfo objectForKey:@"NSLocalizedDescription"]];
            //                block(nil, error);
            //            }];
            break;
        }
        default:
            break;
    }
}

-(void)handleRequestResponseWithOperation:(id)responseObject
                                     path:(NSString*)path
                                    Error:(NSError*)error
                              LoadingFlag:(BOOL)isLoading
                                withStore:(BOOL)isStore
                         withObjectClassz:(Class)classz
                                 andBlock:(BMNetAPIResponceBlock)block
{
    if (error) {
        
        NSLog(@"\n===========error===========\n aPath =%@\n error = %@ \n responseObject %@",path,error,responseObject);
        
//        [BMNetAPIManager showTipInfo:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
     
        id storeResponse =   [[NSUserDefaults standardUserDefaults]objectForKey:path];
    
        if (isStore && storeResponse) {
            
            NSLog(@"读取 上次保存的数据");
            NSError *jsonError;
            id objFromData=[NSJSONSerialization JSONObjectWithData:storeResponse options:NSJSONReadingAllowFragments error:&jsonError];
            id returnObj;
            if (!jsonError) {
               returnObj =[classz ac_objectWithAny:objFromData];
            }
            block(returnObj,NULL);
        }else{
            [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
            [self popSVGAfter:2];
            block(NULL,error);
        }
        
    }else{
        NSError *jsonError;
        if (isStore) {
            NSData  *dataStore =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&jsonError];
            if (!jsonError) {
                NSLog(@"保存接口数据到本地");
                [[NSUserDefaults standardUserDefaults]setObject:dataStore forKey:path];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        }
       
      
        NSLog(@"\n===========responseObject===========\n aPath =%@\n%@",path, responseObject);
        
        id returnObj=[classz ac_objectWithAny:responseObject];
        
        block(returnObj,NULL);
   
  
    }
    
    if (isLoading) {
        [self popSVGAfter:.5f];
    }
    
}


- (void)requestObjectWithPath:(NSString *)aPath
                   withParams:(NSDictionary*)params
             withObjectClassz:(Class)classz
               withMethodType:(NETWORK_METHOD_TYPE)NetworkMethod
                  withLoading:(BOOL)isLoading
                    withStore:(BOOL)isStore
                     andBlock:(BMNetAPIResponceBlock)block{
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"\n===========request===========\n%@    \n%@ ", aPath, params);
    //是否需要loading加载框
    if(isLoading){
        //        [SVProgressHUD showWithStatus:DEF_ALERTMESSAGE];
        [SVProgressHUD show];
    }
    //发起请求
    switch (NetworkMethod) {
        case Get:{
            [self GET:aPath parameters:aPath progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResponseWithOperation:responseObject
                                                    path:aPath
                                                   Error:nil
                                             LoadingFlag:isLoading
                                               withStore:isStore
                                        withObjectClassz:classz
                                                andBlock:block];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResponseWithOperation:nil
                                                    path:aPath
                                                   Error:error
                                             LoadingFlag:isLoading
                                               withStore:isStore
                                        withObjectClassz:classz
                                                andBlock:block];
            }];
            
            
            break;
        }
        case Post:{
            [self POST:aPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResponseWithOperation:responseObject
                 
                                                    path:aPath
                 
                                                   Error:nil
                                             LoadingFlag:isLoading
                                               withStore:isStore
                                        withObjectClassz:classz
                                                andBlock:block];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResponseWithOperation:nil
                                                    path:aPath
                                                   Error:error
                                             LoadingFlag:isLoading
                                               withStore:isStore
                                        withObjectClassz:classz
                                                andBlock:block];
            }];
            
            break;
        }
        case Put:{
            [self PUT:aPath parameters:aPath success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResponseWithOperation:responseObject path:aPath
                 
                                                   Error:nil
                                             LoadingFlag:isLoading
                                               withStore:isStore
                                        withObjectClassz:classz
                                                andBlock:block];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResponseWithOperation:nil path:aPath
                                                   Error:error
                                             LoadingFlag:isLoading
                                               withStore:isStore
                                        withObjectClassz:classz
                                                andBlock:block];
            }];
            
            break;
        }
        case Delete:{
            [self DELETE:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResponseWithOperation:responseObject path:aPath
                                                   Error:nil
                                             LoadingFlag:isLoading
                                               withStore:isStore
                                        withObjectClassz:classz
                                                andBlock:block];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResponseWithOperation:nil path:aPath
                                                   Error:error
                                             LoadingFlag:isLoading
                                               withStore:isStore
                                        withObjectClassz:classz
                                                andBlock:block];
            }];
            break;
        }
        default:
            break;
    }
    
    
}
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
                       andBlock:(BMNetAPIResponceBlock)block
{
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"\n===========request===========\n%@    \n%@ ", aPath, params);
    NSData *imageData = [NSData dataWithContentsOfFile:filePath_];
    
    [self POST:aPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
        NSLog(@"Error: %@", error);
    }];
    
    
}

// 上传图片
-(void)requestImageDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                  withImageData:(NSData *)data
                  withFieldName:(NSString *)fieldName
               withObjectClassz:(Class)classz
                    withLoading:(BOOL)isLoading
                       andBlock:(BMNetAPIResponceBlock)block
{
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"\n===========request===========\n%@    \n%@ ", aPath, params);
    [self POST:aPath
    parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //                             [formData appendPartWithFileData:data name:@"" fileName:@"" mimeType:@"image/png"];
    [formData appendPartWithFileData:data
                                name:fieldName
                            fileName:@"image.jpg"
                            mimeType:@"image/jpeg"];
}
      progress:^(NSProgress * _Nonnull uploadProgress) {
          
      }
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           [self handleRequestResponseWithOperation:responseObject  path:aPath
                                              Error:nil
                                        LoadingFlag:isLoading
                                          withStore:NO
                                   withObjectClassz:classz
                                           andBlock:block];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
           
           [self handleRequestResponseWithOperation:nil  path:aPath
                                              Error:error
                                        LoadingFlag:isLoading
                                          withStore:NO
                                   withObjectClassz:classz
                                           andBlock:block];
           
       }];
    
    
}

@end
