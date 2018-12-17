//
//  NSArray+SCExtension.m
//  LZExtension
//
//  Created by 寕小陌 on 2017/6/28.
//  Copyright © 2017年 寕小陌. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (SCExtension)

- (NSString *_Nonnull)lz_descriptionWithLocale:(id _Nullable)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

- (id _Nullable)lz_safeObjectAtIndex:(NSUInteger)index {
    if ([self count] > 0 && [self count] > index) {
        return [self objectAtIndex:index];
    } else {
        return nil;
    }
}

- (NSArray * _Nonnull)lz_reversedArray {
    return [NSArray lz_reversedArray:self];
}

+ (NSArray * _Nonnull)lz_reversedArray:(NSArray * _Nonnull)array {
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    
    for (id element in enumerator) {
        [arrayTemp addObject:element];
    }
    
    return arrayTemp;
}

- (NSString * _Nonnull)lz_arrayToJson {
    return [NSArray lz_arrayToJson:self];
}

+ (NSString * _Nonnull)lz_arrayToJson:(NSArray * _Nonnull)array {
    NSString *json = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    if (!error) {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    } else {
        return error.localizedDescription;
    }
}

- (id _Nullable)lz_objectAtCircleIndex:(NSInteger)index {
    return [self objectAtIndex:[self lz_superCircle:index lz_maxSize:self.count]];
}

- (NSInteger)lz_superCircle:(NSInteger)index lz_maxSize:(NSInteger)maxSize {
    if (index < 0) {
        index = index % maxSize;
        index += maxSize;
    }
    if (index >= maxSize) {
        index = index % maxSize;
    }
    
    return index;
}
@end
