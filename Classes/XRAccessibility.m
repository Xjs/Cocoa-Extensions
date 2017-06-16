/* *********************************************************************

        Copyright (c) 2010 - 2015 Codeux Software, LLC
     Please see ACKNOWLEDGEMENT for additional information.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:

 * Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
 * Neither the name of "Codeux Software, LLC", nor the names of its 
   contributors may be used to endorse or promote products derived 
   from this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 SUCH DAMAGE.

 *********************************************************************** */

NS_ASSUME_NONNULL_BEGIN

@implementation XRAccessibility

+ (BOOL)isVoiceOverEnabled
{
	CFTypeRef valueRef = CFPreferencesCopyAppValue(CFSTR("voiceOverOnOffKey"), CFSTR("com.apple.universalaccess"));

	BOOL value = (valueRef == kCFBooleanTrue);

	CFRelease(valueRef);

	return value;
}

+ (void)setAccessibilityValueDescription:(nullable NSString *)accessibilityValueDescription forObject:(id)object
{
	NSParameterAssert(object != nil);

	if (COCOA_EXTENSIONS_RUNNING_ON(10.10, Yosemite)) {
		[object setAccessibilityValueDescription:accessibilityValueDescription];
	} else {
		[object accessibilitySetOverrideValue:accessibilityValueDescription
								 forAttribute:NSAccessibilityValueDescriptionAttribute];
	}
}

+ (void)setAccessibilityLabel:(nullable NSString *)accessibilityLabel forObject:(id)object
{
	NSParameterAssert(object != nil);

	if (COCOA_EXTENSIONS_RUNNING_ON(10.10, Yosemite)) {
		[object setAccessibilityLabel:accessibilityLabel];
	} else {
		[object accessibilitySetOverrideValue:accessibilityLabel
								 forAttribute:NSAccessibilityDescriptionAttribute];
	}
}

+ (void)setAccessibilityTitle:(nullable NSString *)accessibilityTitle forObject:(id)object
{
	NSParameterAssert(object != nil);

	if (COCOA_EXTENSIONS_RUNNING_ON(10.10, Yosemite)) {
		[object setAccessibilityTitle:accessibilityTitle];
	} else {
		[object accessibilitySetOverrideValue:accessibilityTitle
								 forAttribute:NSAccessibilityTitleAttribute];
	}
}

@end

NS_ASSUME_NONNULL_END
