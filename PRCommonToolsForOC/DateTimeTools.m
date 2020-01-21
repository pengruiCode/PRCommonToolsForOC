//
//  DateTimeTools.m
//  CommunityPeople
//
//  Created by 彭睿 on 2019/7/22.
//  Copyright © 2019 彭睿. All rights reserved.
//

#import "DateTimeTools.h"

@implementation DateTimeTools

+ (NSString *)getTimestampNowString {
    NSDate* date = [NSDate date];
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld",(long)timeSp];
}


+ (NSString *)getTimestampZore {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSInteger timeSp = [[NSNumber numberWithDouble:[endDate timeIntervalSince1970]] integerValue];
    
    return [NSString stringWithFormat:@"%ld",(long)timeSp];
}


+ (NSString *)getTimestampLongDay:(NSInteger)day {
    NSInteger dis = day; //前后的天数
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    //之后的天数
    theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
    //之前的天数
    //        theDate = [nowDate initWithTimeIntervalSinceNow: -oneDay*dis ];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:theDate];
    
    NSDate* date = [dateFormatter dateFromString:currentDateStr];
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return [NSString stringWithFormat:@"%ld",(long)timeSp];
}


+ (NSString *)compareCurrentTime:(NSString *)compareDate {
    if (compareDate.length == 0 || [compareDate isEqualToString:@""] || [compareDate isEqualToString:@"0"]) {
        return @"";
    }
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:compareDate];
    
    //得到与当前时间差
    NSTimeInterval time = fabs([[NSDate date] timeIntervalSinceDate:timeDate]);
    NSString *returnString = @"";
    
    if(time < 60)
        returnString = @"刚刚";
    else if(time >=60 && time < 3600)
        returnString = [NSString stringWithFormat:@"%.0f分钟前",time/60];
    else if(time >= 3600 && time < 3600 * 24)
        returnString = [NSString stringWithFormat:@"%.0f小时前",time/(60 * 60)];
    else if(time >= 3600 * 24 && time < 3600 * 24 * 30)
        //        returnString = [NSString stringWithFormat:@"%.0f天前",time/(60 * 60 * 24)];
        returnString = compareDate;
    else if(time >= 3600 * 24 * 30 && time < 3600 * 24 * 30 * 12)
        //        returnString = [NSString stringWithFormat:@"%.0f月前",time/(60 * 60 * 24 * 30)];
        returnString = compareDate;
    else if(time >= 3600 * 24 * 30 * 12)
        //        returnString = [NSString stringWithFormat:@"%.0f年前",time/(60 * 60 * 24 * 30 * 12)];
        returnString = compareDate;
    
    return  returnString;
}


+ (NSString *)compareDate:(NSString *)compareDate {
    double unixTimeStamp = compareDate.length >= 13? [[compareDate substringToIndex:compareDate.length -3 ]  doubleValue]: [compareDate doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *destDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    NSDate *date1 = [NSDate date];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    NSInteger interval = [zone secondsFromGMTForDate: date1];
    NSDate * localeDate = [date1  dateByAddingTimeInterval: interval];
    
    NSDateFormatter *_formatter1=[[NSDateFormatter alloc]init];
    [_formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *today =localeDate;
    NSDate *tomorrow, *yesterday,*qiantianDaty;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    qiantianDaty = [today dateByAddingTimeInterval:-2*secondsPerDay];
    
    NSString * todayString = [[_formatter1 stringFromDate:today] substringToIndex:10];
    NSString * dateString = [[_formatter1 stringFromDate:destDate] substringToIndex:10];//接收得时间
    
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"HH:mm"];
    
    if ([dateString isEqualToString:todayString]) {
        [_formatter setDateFormat:@"HH:mm"];
        NSString *_date=[_formatter stringFromDate:destDate];
        return _date;
    } else if ([[dateString substringToIndex:4] isEqualToString:[todayString substringToIndex:4]]) {
        [_formatter setDateFormat:@"MM/dd HH:mm"];
        NSString *_date=[_formatter stringFromDate:destDate];
        return _date;
    } else {
        [_formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        NSString *_date=[_formatter stringFromDate:destDate];
        return _date;
    }
}


+ (NSInteger)compareTimeDifferenceDate:(NSDate *)date otherDate:(NSDate *)otherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *d = [calendar components:unitFlags fromDate:date toDate:otherDate options:0];
    NSInteger totalSecond = [d hour]*3600+[d minute]*60+[d second];
    
    return totalSecond;
}



+ (BOOL)compareTimeDifferenceValueIsRangeMinute:(double)minute fromDate:(NSString *)date otherDate:(NSString *)otherDate {
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [fmt dateFromString:date];
    NSDate *date2 = [fmt dateFromString:otherDate];
    NSInteger totalSecond = [date1 timeIntervalSinceDate:date2];
    
    if (totalSecond > minute * 60.0) {
        return NO;
    }else{
        return YES;
    }
}



+ (BOOL)isToday:(NSDate *)date {
    NSRange range;
    range.length = 10;
    range.location = 0;
    NSString *timeStr = [DateTimeTools getTimestampNowString];
    NSTimeInterval _interval=[timeStr.length >= 13 ? [timeStr substringToIndex:10]:timeStr doubleValue];
    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSTimeZone *timeZone=[NSTimeZone timeZoneWithName:@"UTC"];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [formatter setTimeZone:timeZone];
    NSString *dateNewString = [formatter stringFromDate:nowDate];
    NSString *dateOldString = [formatter stringFromDate:date];
    if ([[dateNewString substringWithRange:range] isEqualToString:[dateOldString substringWithRange:range]]) {
        return YES;
    }
    return NO;
    
}


+ (BOOL)isTodayWithString:(NSString *)dateString{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *now = [NSDate date];
    NSString *nowDate = [format stringFromDate:now];
    return [[dateString substringWithRange:NSMakeRange(0, 10)] isEqualToString:nowDate];
}


+ (BOOL)isYersterday:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *now = [NSDate date];
    NSDate *date = [formatter dateFromString:dateString];
    
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *createdDate = [formatter stringFromDate:date];
    NSString *nowDate = [formatter stringFromDate:now];
    date = [formatter dateFromString:createdDate];
    now = [formatter dateFromString:nowDate];
    NSCalendar * celendar = [NSCalendar currentCalendar];
    NSDateComponents * Components = [celendar components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:now toDate:date options:0];
    return Components.month == 0 && Components.day == 1 && Components.year == 0;
}


+ (BOOL)isThisYear:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *now = [NSDate date];
    NSDate *date = [formatter dateFromString:dateString];
    
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    NSDateComponents *dateComps = [calendar components:unit fromDate:date];
    
    return nowCmps.year == dateComps.year;
}


+ (BOOL)isThisMonth:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *now = [NSDate date];
    NSDate *date = [formatter dateFromString:dateString];
    
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    NSDateComponents *dateComps = [calendar components:unit fromDate:date];
    
    return nowCmps.year == dateComps.year && nowCmps.month == dateComps.month;
}


+ (NSString *)year:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    formatter.dateFormat = @"yyyy";
    return [formatter stringFromDate:date];
}

+ (NSString *)year{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy";
    return [formatter stringFromDate:[NSDate date]];
}


+ (NSString *)month{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM";
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSString *)month:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    formatter.dateFormat = @"MM月";
    return [formatter stringFromDate:date];
}


+ (NSInteger )dateNumber {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}


+ (NSString *)toDay {
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}


+ (NSString *)yearAndMonthAndDay {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}


+ (NSString *)nowTimeDetails {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}


+ (NSString *)yearAndMonth{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}


+ (NSString *)monthAndDay:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    formatter.dateFormat = @"MM-dd";
    return [formatter stringFromDate:date];
}


+ (NSString *)hourAndMinute:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    formatter.dateFormat = @"HH:mm";
    return [formatter stringFromDate:date];
}


+ (NSString *)weekDayFromDateString:(NSString *)dateString{
    if (!dateString) {
        return @"";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:dateString];
    
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *currentComps = [[NSDateComponents alloc]init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    currentComps = [currentCalendar components:unitFlags fromDate:date];
    NSInteger week = [currentComps weekday];
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周天",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    return [NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week - 1]];
}


+ (NSString *)dateFromTimestamp:(NSString *)timeStamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


+ (NSString *)dateFromTimestampDetails:(NSString *)timeStamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(long)seconds/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(long)(seconds%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
}


+ (NSString *)getDDMMSSFromSS:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    NSString *str_day = [NSString stringWithFormat:@"%ld",(long)seconds/(3600 * 24)];
    NSString *str_hour = [NSString stringWithFormat:@"%ld",(long)(seconds % (3600 * 24)) / 3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(long)(seconds%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"还剩%@天:%@:%@:%@",str_day,str_hour,str_minute,str_second];
    return format_time;
}


+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (!format) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
       [formatter setDateFormat:format];
    }
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime];
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return timeSp;
}


+ (int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt1 = [[NSDate alloc]init];
    NSDate *dt2 = [[NSDate alloc]init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1;break;
            //date02比date01小
        case NSOrderedDescending: ci=-1;break;
            //date02=date01
        case NSOrderedSame: ci=0;break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1);break;
    }
    return ci;
}

@end
