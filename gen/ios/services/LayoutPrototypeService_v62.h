/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 * 
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 * 
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

/**
 * author: Bruno Farache
 */
@interface LayoutPrototypeService_v62 : NSObject

- (NSDictionary *)updateLayoutPrototype:(NSNumber *)layoutPrototypeId nameMap:(NSDictionary *)nameMap description:(NSString *)description active:(BOOL)active serviceContext:(NSDictionary *)serviceContext;
- (void)deleteLayoutPrototype:(NSNumber *)layoutPrototypeId;
- (NSArray *)search:(NSNumber *)companyId active:(NSDictionary *)active obc:(NSDictionary *)obc;
- (NSDictionary *)addLayoutPrototype:(NSDictionary *)nameMap description:(NSString *)description active:(BOOL)active serviceContext:(NSDictionary *)serviceContext;
- (NSDictionary *)getLayoutPrototype:(NSNumber *)layoutPrototypeId;

@end