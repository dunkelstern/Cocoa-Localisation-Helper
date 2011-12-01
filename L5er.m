/*
 *  L5er.h
 *  Autotranslate XIB file strings
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

#import "L5er.h"

@implementation UIView (l5erExtension)

- (void)autotranslate {
    for(UIView *subview in [self subviews]) {
		if([subview respondsToSelector:@selector(autotranslate:)]) {
            [subview autotranslate];
        }
    }
}

@end


@implementation UIButton (l5erExtension)

- (void)autotranslate {
    L5er *l5er = [L5er l5er];
    [self setTitle:[l5er localizedString:[self titleForState:UIControlStateNormal]] forState:UIControlStateNormal];
    [self setTitle:[l5er localizedString:[self titleForState:UIControlStateHighlighted]] forState:UIControlStateHighlighted];
    [self setTitle:[l5er localizedString:[self titleForState:UIControlStateDisabled]] forState:UIControlStateDisabled];
    [self setTitle:[l5er localizedString:[self titleForState:UIControlStateSelected]] forState:UIControlStateSelected];
}

@end

@implementation UILabel (l5erExtension)

- (void)autotranslate {
    L5er *l5er = [L5er l5er];
    [self setText:[l5er localizedString:[self text]]];
}

@end

@implementation UITextView (l5erExtension)

- (void)autotranslate {
    L5er *l5er = [L5er l5er];
    [self setText:[l5er localizedString:[self text]]];
}

@end

@implementation UITabBar (l5erExtension)

- (void)autotranslate {
    L5er *l5er = [L5er l5er];
	for (UIBarItem *item in [self items])
		[item setTitle:[l5er localizedString:[item title]]];
}
@end

@implementation UIToolbar (l5erExtension)

- (void)autotranslate {
    L5er *l5er = [L5er l5er];
	for (UIBarItem *item in [self items])
		[item setTitle:[l5er localizedString:[item title]]];
}

@end

@implementation UISegmentedControl (l5erExtension)

- (void)autotranslate {
    L5er *l5er = [L5er l5er];
	for (NSUInteger i = 0; i < [self numberOfSegments]; i++) {
		[self setTitle:[l5er localizedString:[self titleForSegmentAtIndex:i]] forSegmentAtIndex:i];
	}
}

@end

@implementation UINavigationBar (l5erExtension)

- (void)autotranslate {
    L5er *l5er = [L5er l5er];
	for (UINavigationItem *item in [self items]) {
		[item setTitle:[l5er localizedString:[item title]]];
	}
}

@end

@interface L5er (Internal)
- (id)initWithTable:(NSString *)table bundle:(NSBundle *)bundle;
@end

@implementation L5er

@synthesize table;
@synthesize bundle;

+ (L5er *)l5er {
    static L5er *localizer = nil;
    if (localizer == nil) {
        localizer = [[[self class] alloc] initWithTable:nil bundle:nil];
    }
	return localizer;	
}

- (id)initWithTable:(NSString*)theTable bundle:(NSBundle*)theBundle {
	self = [super init];
    if(self) {
		if (!theTable) {
			theTable = @"Localizable"; 
		}
		if (!theBundle) {
			theBundle = [NSBundle mainBundle];		    
		}
		table = theTable;
		bundle = theBundle;
	}
    return self;
}

- (NSString *)localizedString:(NSString*)string {
	if ((string) && ([string length] > 0)) {
		string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		return NSLocalizedStringFromTableInBundle(string, table, bundle, nil);
	}
    return string;
}

+ (NSString *)localizedResourcePathFor:(NSString *)basename ofType:(NSString *)type {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defaults objectForKey:@"AppleLanguages"];

	// find most appropriate resource file
	for (NSString *lang in languages) {
		NSString *twoChar = [lang substringToIndex:2];
		NSString *name = [NSString stringWithFormat:@"%@_%@", basename, twoChar];
		NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
		if (path != nil) {
			return path;
		}
	}
	return nil;
}

+ (UIImage *)localizedImageFor:(NSString *)basename ofType:(NSString *)type {
	return [UIImage imageWithContentsOfFile:[L5er localizedResourcePathFor:basename ofType:type]];
}

- (void)translateView:(UIView*)view {    
	[view autotranslate];
}

@end
