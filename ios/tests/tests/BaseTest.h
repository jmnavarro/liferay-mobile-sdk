//
//  testsTests.m
//  testsTests
//
//  Created by jmWork on 24/03/14.
//  Copyright (c) 2014 Liferay. All rights reserved.
//

#import <XCTest/XCTest.h>

@class LRSession;

@interface BaseTest : XCTestCase

@property (strong) NSDictionary* settings;
@property (strong, readonly) LRSession* session;

@end
