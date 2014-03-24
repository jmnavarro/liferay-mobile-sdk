//
//  testsTests.m
//  testsTests
//
//  Created by jmWork on 24/03/14.
//  Copyright (c) 2014 Liferay. All rights reserved.
//

#import "BaseTest.h"
#import "LRDLAppService_v62.h"
#import "LRBatchSession.h"

@interface DLAppServiceTest : BaseTest

@property (strong) LRDLAppService_v62 *service;

@end


@implementation DLAppServiceTest


- (void)setUp
{
    [super setUp];

    self.service = [[LRDLAppService_v62 alloc] init:self.session];
}


- (void)testAddFolder
{
    long long repositoryId = [self.settings[@"repositoryId"] longLongValue];
    
    NSString *randomName = [NSString stringWithFormat:@"test-name-%@", [[NSUUID UUID] UUIDString]];
    NSString *randomDesc = [NSString stringWithFormat:@"test-desc-%@", [[NSUUID UUID] UUIDString]];

    NSError *error = nil;
    NSDictionary* result = [self.service addFolderWithRepositoryId:repositoryId
                                                    parentFolderId:0
                                                              name:randomName
                                                       description:randomDesc
                                                    serviceContext:@{}
                                                             error:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(result);
    
    XCTAssertEqualObjects(randomName, result[@"name"]);
    XCTAssertEqualObjects(randomDesc, result[@"description"]);
    
    long long folderId = [result[@"folderId"] longLongValue];
    
    [self getFolderWithId:folderId shouldExist:YES];
    [self deleteFolderWithId:folderId];
}

- (void)deleteFolderWithId:(long long)folderId
{
    NSError *error = nil;
    [self.service deleteFolderWithFolderId:folderId error:&error];
    
    XCTAssertNil(error);
    
    [self getFolderWithId:folderId shouldExist:NO];
}

- (void)getFolderWithId:(long long)folderId shouldExist:(BOOL)exists
{
    NSError *error = nil;
    NSDictionary* result = [self.service getFolderWithFolderId:folderId error:&error];
    
    if (exists) {
        XCTAssertNil(error);
        XCTAssertNotNil(result);
        
        XCTAssertEqualObjects(result[@"folderId"], @(folderId));
    }
    else {
        XCTAssertNil(result);
        XCTAssertNotNil(error);
        XCTAssertTrue([[error localizedDescription] hasSuffix:@"NoSuchFolderException"]);
    }
}

- (void)testBatchAddFolders
{
    LRBatchSession *batch = [[LRBatchSession alloc] init:self.session];
    self.service = [[LRDLAppService_v62 alloc] init:batch];
    
    long long repositoryId = [self.settings[@"repositoryId"] longLongValue];
    
    NSString *name1 = [NSString stringWithFormat:@"1-test-name-%@", [[NSUUID UUID] UUIDString]];
    NSString *name2 = [NSString stringWithFormat:@"2-test-name-%@", [[NSUUID UUID] UUIDString]];
    NSString *desc1 = [NSString stringWithFormat:@"1-test-desc-%@", [[NSUUID UUID] UUIDString]];
    NSString *desc2 = [NSString stringWithFormat:@"2-test-desc-%@", [[NSUUID UUID] UUIDString]];
    
    NSError *error = nil;
    
    [self.service addFolderWithRepositoryId:repositoryId
                             parentFolderId:0
                                       name:name1
                                description:desc1
                             serviceContext:@{}
                                      error:&error];
    XCTAssertNil(error);

    [self.service addFolderWithRepositoryId:repositoryId
                             parentFolderId:0
                                       name:name2
                                description:desc2
                             serviceContext:@{}
                                      error:&error];
    XCTAssertNil(error);
    
    NSArray* result = [batch invoke:&error];

    XCTAssertNil(error);
    XCTAssertNotNil(result);
    XCTAssertEqual(2, [result count]);
    
    XCTAssertEqualObjects(name1, result[0][@"name"]);
    XCTAssertEqualObjects(desc1, result[0][@"description"]);

    XCTAssertEqualObjects(name2, result[1][@"name"]);
    XCTAssertEqualObjects(desc2, result[1][@"description"]);
    
    NSArray* ids = [result valueForKey:@"folderId"];

    [self batchGetFoldersWithIds:ids shouldExist:YES];
    [self batchDeleteFoldersWithIds:ids];
}

- (void)batchDeleteFoldersWithIds:(NSArray*)folderIds
{
    LRBatchSession *batch = [[LRBatchSession alloc] init:self.session];
    self.service = [[LRDLAppService_v62 alloc] init:batch];
    
    NSError *error = nil;

    for (id folderId in folderIds) {
        [self.service deleteFolderWithFolderId:[folderId longLongValue] error:&error];
        XCTAssertNil(error);
    }
    
    NSArray* results = [batch invoke:&error];
    
    XCTAssertNil(error);
    XCTAssertNotNil(results);
    XCTAssertEqual([folderIds count], [results count]);
    
    [self batchGetFoldersWithIds:folderIds shouldExist:NO];
}


- (void)batchGetFoldersWithIds:(NSArray*)folderIds shouldExist:(BOOL)exists
{
    LRBatchSession *batch = [[LRBatchSession alloc] init:self.session];
    self.service = [[LRDLAppService_v62 alloc] init:batch];
    
    NSError *error = nil;

    for (id folderId in folderIds) {
        [self.service getFolderWithFolderId:[folderId longLongValue] error:&error];
        XCTAssertNil(error);
    }
    
    NSArray* results = [batch invoke:&error];

    if (exists) {
        XCTAssertNil(error);
        XCTAssertNotNil(results);
        XCTAssertEqual([folderIds count], [results count]);

        for (int i = 0; i < [results count]; ++i) {
            XCTAssertEqualObjects(results[i][@"folderId"], folderIds[i]);
        }
    }
    else {
        XCTAssertNil(results);
        XCTAssertNotNil(error);
        XCTAssertTrue([[error localizedDescription] hasSuffix:@"NoSuchFolderException"]);
    }
}

@end
