//
//  httpConfigure.h
//  YIJIa
//
//  Created by sven on 3/24/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#ifndef YIJIa_httpConfigure_h
#define YIJIa_httpConfigure_h

#define kUserName @"login_userName"
#define kUserPassword @"login_userPassword"

#define kTimeoutCount 2.0f
#define kBaseURL @"http://121.41.47.120/backend_service"

//登录
#define kLoginAuth(_name, _password) [NSString stringWithFormat:@"%@/queryInfo/login.do?tech_number=%@&password=%@", kBaseURL, _name, _password]

//查询下单历史
#define kHistoryList(_name) [NSString stringWithFormat:@"%@/standInterface/queryList.do?sql=select ayj_orders.* ,ayj_subject.sub_name from ayj_orders,ayj_subject where ayj_orders.sub_id = ayj_subject.sub_id AND tech_number='%@'", kBaseURL, _name]

//查询评论
#define kComment(_order_id) [NSString stringWithFormat:@"%@/standInterface/queryOne.do?sql=select * from ayj_user_comment where order_id='%@'", kBaseURL, _order_id]

#define kTechnician @"http://121.41.47.120/backend_service/standInterface/queryList.do?sql=select * from ayj_technician where tech_number='%@'"

//查询排班
#define kTechnician_time(_name) [NSString stringWithFormat:@"%@/standInterface/queryList.do?sql=select * from ayj_technician_rest where tech_number='%@'", kBaseURL, _name]

//week
typedef enum {
    Sun = 0,
    Mon,
    Tues,
    Wed,
    Thur,
    Fri,
    Sat
}WeekDay;
#endif
