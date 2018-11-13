//
//  EXAppAuth+JSON.m
//  EXAppAuth
//
//  Created by Evan Bacon on 11/13/18.
//

#import <EXAppAuth/EXAppAuth+JSON.h>
#import <EXCore/EXUtilities.h>

@implementation EXAppAuth (JSON)

+ (NSString *)dateNativeToJSON:(NSDate *)input
{
  if (!input) return nil;
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
  [dateFormatter setTimeZone:timeZone];
  [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
  [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z"];
  return [dateFormatter stringFromDate:input];
}

+ (NSDictionary *)tokenResponseNativeToJSON:(OIDTokenResponse *)input
{
  if (!input) return nil;
  
  return @{ 
           @"accessToken": nullIfEmpty([input accessToken]),
           @"accessTokenExpirationDate": EXNullIfNil([[self class] dateNativeToJSON:[input accessTokenExpirationDate]]),
           @"additionalParameters": EXNullIfNil([input additionalParameters]),
           @"idToken": nullIfEmpty([input idToken]),
           @"tokenType": nullIfEmpty([input tokenType]),
           };
}


@end
