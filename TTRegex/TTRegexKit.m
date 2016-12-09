//
//  TTRegexKit.m
//  https://github.com/JadynSky/TTRegex
//
//  Created by WuZhongTian on 16/5/26.
//  Copyright (c) 2016年 WuZhongTian. All rights reserved.
//

#import "TTRegexKit.h"

@implementation TTRegexKit

@end

@implementation TTRegexKit

/**返回匹配正则规则的文字片段*/
+(void)stringsMatchedByText:(NSString *)text pattern:(NSString *)pattern  TextPart:(void (^)(TTTextPart  *textPart))textPart
{
    if(pattern){//规则若为nil 返回空
        
        if(textPart){//block回调者必须拥有block
            
            NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:pattern options:0 error:nil];
            NSArray *results = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
            
            if(results.count != 0){//匹配到结果了

                for(NSInteger i = 0 ; i<results.count ; i++)
                {
                   NSTextCheckingResult *result = results[i];
                    //打印: range      subString
                    TTTextPart *part = [[TTTextPart alloc]init];
                    part.range = result.range;
                    part.text  = [text substringWithRange:result.range];
                    part.index = i;
                    part.isRegular = YES;
                    //返回
                    textPart(part);
                }
                
            }else{//没匹配到结果
              
            }
        }
        
    }else{

    }

}


/**返回不匹配正则规则的文字片段*/
+(void)stringsSeparatedByText:(NSString *)text pattern:(NSString *)pattern  TextPart:(void (^)(TTTextPart  *textPart))textPart
{
    if(pattern){//规则若为nil  全部字符串返回
        
        if(textPart){//block回调者必须拥有block
            
            NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:pattern options:0 error:nil];
            NSArray *results = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
            
            if(results.count != 0){//匹配到结果了
               
                NSInteger myLocation = 0;
                
                for(NSInteger i = 0 ; i <= results.count  ; i++)
                {
                    NSTextCheckingResult *result;
                    
                    if(i >= results.count){
                        
                      result = results[results.count - 1];
                    }else{
                        
                      result = results[i];
                    }
                    
                    TTTextPart *part = [[TTTextPart alloc]init];

                    if(myLocation == result.range.location)
                    {
                         myLocation = result.range.location + result.range.length;
                    }else
                    {
                        if(myLocation < result.range.location)
                        {
                            part.range = NSMakeRange(myLocation, result.range.location - myLocation);
                            part.text  = [text substringWithRange:part.range];
                            part.index = i;
                            part.isRegular = NO;
                            textPart(part);
                            myLocation = result.range.location + result.range.length;
                        }else if((myLocation > result.range.location) && (myLocation < text.length))
                        {
                            part.range = NSMakeRange(myLocation, text.length - myLocation);
                            part.text  = [text substringWithRange:part.range];
                            part.index = i;
                            part.isRegular = NO;
                            textPart(part);
                            myLocation = result.range.location + text.length;
                        }else
                        {
                            
                        }
                    }
                }
                
            }else{//没匹配到结果 全部字符串返回
                
                TTTextPart *part = [[TTTextPart alloc]init];
                part.range = NSMakeRange(0, text.length);
                part.text  = text;
                part.index = 0;
                part.isRegular = NO;
                textPart(part);
            }
        }
        
    }else{
        
        TTTextPart *part = [[TTTextPart alloc]init];
        part.range = NSMakeRange(0, text.length);
        part.text  = text;
        part.index = 0;
        textPart(part);
    }
}


/**返回全部文字片段,用正则规则分段*/
+(void)stringsAllPartByText:(NSString *)text pattern:(NSString *)pattern  TextPart:(void (^)(TTTextPart  *textPart))textPart
{
    NSMutableArray *arr = [NSMutableArray array];
    
    [TTRegexKit stringsMatchedByText:text pattern:pattern TextPart:^(TTTextPart *textPart) {
        
         [arr addObject:textPart];
        
    }];
    
    [TTRegexKit stringsSeparatedByText:text pattern:pattern TextPart:^(TTTextPart *textPart) {
        
        [arr addObject:textPart];
        
    }];

    [arr sortUsingComparator:^NSComparisonResult(TTTextPart *part1,TTTextPart *part2) {

        if(part1.range.location > part2.range.location)
        {
            return NSOrderedDescending;
        }
        
        return NSOrderedAscending;
    }];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        TTTextPart * part = arr[i];
        
        part.index = i;
        
      if(textPart)
      {
          textPart(part);
      }
        
    }
    
}


@end
