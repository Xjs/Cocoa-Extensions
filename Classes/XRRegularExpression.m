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

@implementation XRRegularExpression

+ (BOOL)string:(NSString *)haystack isMatchedByRegex:(NSString *)needle
{
	return [XRRegularExpression string:haystack isMatchedByRegex:needle withoutCase:NO];
}

+ (BOOL)string:(NSString *)haystack isMatchedByRegex:(NSString *)needle withoutCase:(BOOL)caseless
{
	NSParameterAssert(haystack != nil);
	NSParameterAssert(needle != nil);

    NSRange strRange = NSMakeRange(0, haystack.length);

	NSRegularExpression *regex;

	if (caseless) {
		regex = [NSRegularExpression regularExpressionWithPattern:needle options:NSRegularExpressionCaseInsensitive error:NULL];
	} else {
		regex = [NSRegularExpression regularExpressionWithPattern:needle options:0 error:NULL];
	}

	NSUInteger numMatches = [regex numberOfMatchesInString:haystack options:0 range:strRange];

	return (numMatches >= 1);
}

+ (NSRange)string:(NSString *)haystack rangeOfRegex:(NSString *)needle
{
	return [XRRegularExpression string:haystack rangeOfRegex:needle withoutCase:NO];
}

+ (NSRange)string:(NSString *)haystack rangeOfRegex:(NSString *)needle withoutCase:(BOOL)caseless
{
	NSParameterAssert(haystack != nil);
	NSParameterAssert(needle != nil);

    NSRange strRange = NSMakeRange(0, haystack.length);

	NSRegularExpression *regex;

	if (caseless) {
		regex = [NSRegularExpression regularExpressionWithPattern:needle options:NSRegularExpressionCaseInsensitive error:NULL];
	} else {
		regex = [NSRegularExpression regularExpressionWithPattern:needle options:0 error:NULL];
	}

	NSRange resultRange = [regex rangeOfFirstMatchInString:haystack options:0 range:strRange];

	return resultRange;
}

+ (NSString *)string:(NSString *)haystack replacedByRegex:(NSString *)needle withString:(NSString *)puppy
{
	NSParameterAssert(haystack != nil);
	NSParameterAssert(needle != nil);
	NSParameterAssert(puppy != nil);

	NSRange strRange = NSMakeRange(0, haystack.length);

	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:needle options:0 error:NULL];

	NSString *newString = [regex stringByReplacingMatchesInString:haystack options:0 range:strRange withTemplate:puppy];

	return newString;
}

+ (NSUInteger)totalNumberOfMatchesInString:(NSString *)haystack withRegex:(NSString *)needle
{
	return [XRRegularExpression totalNumberOfMatchesInString:haystack withRegex:needle withoutCase:NO];
}

+ (NSUInteger)totalNumberOfMatchesInString:(NSString *)haystack withRegex:(NSString *)needle withoutCase:(BOOL)caseless
{
	NSParameterAssert(haystack != nil);
	NSParameterAssert(needle != nil);

    NSRange strRange = NSMakeRange(0, haystack.length);
	
	NSRegularExpression *regex;
	
	if (caseless) {
		regex = [NSRegularExpression regularExpressionWithPattern:needle options:NSRegularExpressionCaseInsensitive error:NULL];
	} else {
		regex = [NSRegularExpression regularExpressionWithPattern:needle options:0 error:NULL];
	}
	
	NSArray *matches = [regex matchesInString:haystack options:0 range:strRange];

	return matches.count;
}

+ (NSArray *)matchesInString:(NSString *)haystack withRegex:(NSString *)needle
{
	return [XRRegularExpression matchesInString:haystack withRegex:needle withoutCase:NO substring:NO];
}

+ (NSArray *)matchesInString:(NSString *)haystack withRegex:(NSString *)needle withoutCase:(BOOL)caseless
{
	return [XRRegularExpression matchesInString:haystack withRegex:needle withoutCase:caseless substring:NO];
}

+ (NSArray *)matchesInString:(NSString *)haystack withRegex:(NSString *)needle withoutCase:(BOOL)caseless substring:(BOOL)returnSubstrings
{
	NSParameterAssert(haystack != nil);
	NSParameterAssert(needle != nil);

    NSRange strRange = NSMakeRange(0, haystack.length);

	NSRegularExpression *regex;

	if (caseless) {
		regex = [NSRegularExpression regularExpressionWithPattern:needle options:NSRegularExpressionCaseInsensitive error:NULL];
	} else {
		regex = [NSRegularExpression regularExpressionWithPattern:needle options:0 error:NULL];
	}

	NSArray *matches = [regex matchesInString:haystack options:0 range:strRange];

	if (matches.count == 0) {
		return @[];
	}
	
	NSMutableArray<NSString *> *realMatches = [NSMutableArray array];

	for (NSTextCheckingResult *result in matches) {
		NSString *newStr = [haystack substringWithRange:result.range];

		[realMatches addObject:newStr];
	}

	return [realMatches copy];
}

+ (BOOL)matches:(NSArray * _Nullable * _Nonnull)matches inString:(NSString *)haystack withRegex:(NSString *)needle
{
	return [XRRegularExpression matches:matches inString:haystack withRegex:needle withoutCase:NO substring:NO];
}

+ (BOOL)matches:(NSArray * _Nullable * _Nonnull)matches inString:(NSString *)haystack withRegex:(NSString *)needle withoutCase:(BOOL)caseless
{
	return [XRRegularExpression matches:matches inString:haystack withRegex:needle withoutCase:caseless substring:NO];
}

+ (BOOL)matches:(NSArray * _Nullable * _Nonnull)matches inString:(NSString *)haystack withRegex:(NSString *)needle withoutCase:(BOOL)caseless substring:(BOOL)returnSubstrings
{
	NSArray *matchesOut = [XRRegularExpression matchesInString:haystack withRegex:needle withoutCase:caseless substring:returnSubstrings];
	
	if (matches) {
		*matches = matchesOut;
	}
	
	return (matchesOut.count > 0);
}

@end

NS_ASSUME_NONNULL_END
