//
//  Best64.m
//  demo_demo
//
//  Created by Yibo Niu on 16/10/11.
//  Copyright © 2016年 Yibo Niu. All rights reserved.
//

#import "Best64.h"

@implementation Best64

static Best64* Best64ss;

+(id)instancebest{
    if (Best64ss == nil) {
        Best64ss = [[Best64 alloc]init];
        
    }
    return Best64ss;
}
+(id)setencryptionBybest64String:(NSString*)Strings{
    
    NSData *nsdata = [Strings
                      dataUsingEncoding:NSUTF8StringEncoding];
    // 加密
    // Get NSString from NSData object in Base64
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
    
    NSString * temp = nil;
    
    // Print the Base64 encoded string
    
    NSLog(@"Encoded=================: %@", base64Encoded);
    
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<[base64Encoded length]; i++) {
        temp  = [base64Encoded substringWithRange:NSMakeRange(i, 1)];
        
        [tempArray addObject:temp];
        
        [base64Encoded enumerateSubstringsInRange:NSMakeRange(0, Strings.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            [arr addObject:substring];
        }];
        
        //NSLog(@"//////////%@",tempArray[i]);
    }
    NSString * strings = @"";
    NSString * strings1 = @"";
    NSString * strings3 = @"_";
    NSString * mainstr = @"";
    NSString * qianstr = @"z";
    NSString * houstr = @"m";
    
    //NSMutableArray * mutable = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    NSMutableArray * arrays = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"G",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"*",@"!",@"/",@"+",@"=",@"#",nil];
    
    [base64Encoded enumerateSubstringsInRange:NSMakeRange(0, base64Encoded.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [arr addObject:substring];
    }];
    
    //NSLog(@"-------------------%lu",(unsigned long)arr.count);
    
    NSMutableArray * mutables = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i< arr.count; i++) {
        
        strings = [NSString stringWithFormat:@"%@",arr[i]];
        
        strings1 = [NSString stringWithFormat:@"%@",arrays[(i)%arrays.count]];
        
        mainstr = [NSString stringWithFormat:@"%@%@%@",strings,strings1,strings3];
        
        int asciiCode = [strings characterAtIndex:0];
        
        
        int asciiCode2 = [strings1 characterAtIndex:0];
        
        int mainstrs = asciiCode+asciiCode2;
        
        mainstr = [NSString stringWithFormat:@"%d%@",mainstrs,strings3];
        
        [mutables addObject:mainstr];
    }
    NSString *stringzzz = [mutables componentsJoinedByString:@","];
    
    NSString* htmls = [stringzzz stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@","] withString:@""];
    
    
    NSString * strit  = [NSString stringWithFormat:@"%@%@%@",qianstr,htmls,houstr];
    
    NSLog(@"%@",strit);
    
    // Let's go the other way...
    
    // 解密
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:base64Encoded options:0];
    
    // Decoded NSString from the NSData
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    NSLog(@"Decoded=================: %@", base64Decoded);

    
    return Strings;

}


@end
