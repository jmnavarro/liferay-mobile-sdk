/**
 * Copyright (c) 2000-2014 Liferay, Inc. All rights reserved.
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

package com.liferay.mobile.sdk.util;

import java.io.IOException;
import java.io.InputStream;

import java.util.Properties;

import org.apache.commons.lang.WordUtils;

/**
 * @author Bruno Farache
 */
public class LanguageUtil {

	public static final String BOOLEAN = "boolean";

	public static final String BYTE_ARRAY = "byte[]";

	public static final String DOUBLE = "double";

	public static final String FILE = "object<java.io.File>";

	public static final String INT = "int";

	public static final String LONG = "long";

	public static final String OBJECT_PREFIX = "object<";

	public static final String STRING = "string";

	public static final String VOID = "void";

	public LanguageUtil() {
		_classNames = new Properties();

		InputStream is = getClass().getResourceAsStream(
			"/class-names.properties");

		try {
			_classNames.load(is);
		}
		catch (IOException ioe) {
			ioe.printStackTrace();
		}
	}

	public String capitalize(String word) {
		return WordUtils.capitalize(word);
	}

	public String getJSONWrapperClassName(String type) {
		if (type.startsWith(OBJECT_PREFIX)) {
			return type.substring(7, type.length() - 1);
		}

		return type;
	}

	public String getMethodName(String path) {
		String last = getMethodURL(path);

		String[] methodName = last.split("-");

		StringBuilder sb = new StringBuilder();

		for (int i = 0; i < methodName.length; i++) {
			String word = methodName[i];

			if (i > 0) {
				word = capitalize(word);
			}

			sb.append(word);
		}

		return sb.toString();
	}

	public String getMethodURL(String path) {
		int index = path.lastIndexOf("/") + 1;

		return path.substring(index);
	}

	public String getServiceClassName(String serviceContext) {
		StringBuilder sb = new StringBuilder();

		String className = _classNames.getProperty(serviceContext);

		if (className == null) {
			className = WordUtils.capitalize(serviceContext);
		}

		sb.append(className);
		sb.append("Service");

		return sb.toString();
	}

	public boolean isArray(String type) {
		if (type.endsWith("[]") || type.equals("object<list>") ||
			type.equals("object<com.liferay.portal.kernel.json.JSONArray>") ||
			type.startsWith("list")) {

			return true;
		}

		return false;
	}

	private Properties _classNames;

}