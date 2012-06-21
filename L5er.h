/*
 *  L5er.h
 *  Autotranslate XIB file strings
 *
 *  Usage:
 *  1. Put your translated strings in your "Localizable.strings" file
 *     (you may use the localisationextractor.py script to get a
 *      untranslated file to base your strings file on)
 *  2. Include "L5er.h" in your "prefix.pch" file
 *  3. In "- (void)viewDidLoad;" call "[self.view autotranslate]" the
 *     L5er class categories for UIView subclasses view will traverse
 *     the view hierarchy recursively and try to replace all strings
 *     it finds.
 *
 *  Currently supported UIView subclasses:
 *  UIView, UIButton, UILabel, UITextView, UITabBar, UIToolbar,
 *  UISegmentedControl, UINavigationBar
 *
 *  If you want to add autotranslate to your custom UIView subclasses
 *  just implement a "-(void)autotranslate" method, it will be called
 *  automatically.
 *
 *
 *  Created by Johannes Schriewer on 2011-11-30
 *  Copyright (c) 2011 planetmutlu.
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions
 *  are met:
 *
 *  - Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  - Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
 *  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>


@interface L5er : NSObject

@property (readonly) NSString *table;
@property (readonly) NSBundle *bundle;

/** @brief l5er singleton initializer
 */
+ (L5er *)l5er;

/**
 * @brief fetch localized strings
 *
 * @param string the string to translate
 */
- (NSString *)localizedString:(NSString*)string;

/** 
 * @brief fetch localized resource path
 *
 * @param basename the name of the resource (will be extended with "_<2 char language code>")
 * @param type resource type
 */
+ (NSString *)localizedResourcePathFor:(NSString *)basename ofType:(NSString *)type;

/**
 * @brief load a localized image
 *
 * @param basename the name of the image (will be extended with "_<2 char language code>")
 * @param type the type of the image (normally "png" or "jpg")
 */
+ (UIImage *)localizedImageFor:(NSString *)basename ofType:(NSString *)type;

/**
 * @brief start localizing a UIView recursively using the default strings file
 *
 * @param view the view to localize
 */
- (void)translateView:(UIView*)view;

@end

@interface UIView (l5erExtension)
- (void)autotranslate;
@end

@interface UIButton (l5erExtension)
- (void)autotranslate;
@end

@interface UILabel (l5erExtension)
- (void)autotranslate;
@end

@interface UITextView (l5erExtension)
- (void)autotranslate;
@end

@interface UITabBar (l5erExtension)
- (void)autotranslate;
@end

@interface UIToolbar (l5erExtension)
- (void)autotranslate;
@end

@interface UISegmentedControl (l5erExtension)
- (void)autotranslate;
@end

@interface UINavigationBar (l5erExtension)
- (void)autotranslate;
@end

@interface UIBarButtonItem (l5erExtension)
- (void)autotranslate;
@end
