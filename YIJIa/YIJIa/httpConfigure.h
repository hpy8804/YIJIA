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
#define kBaseURL @"http://121.41.47.120/backend_service/"
#define kLoginAuth @"http://121.41.47.120/backend_service/queryInfo/login.do?tech_number=%@&password=%@"
#define kHistoryList @"http://121.41.47.120/backend_service/standInterface/queryList.do?sql=select ayj_orders.* ,ayj_subject.sub_name from ayj_orders,ayj_subject where ayj_orders.sub_id = ayj_subject.sub_id AND tech_number='%@'"
#define kTechnician @"http://121.41.47.120/backend_service/standInterface/queryList.do?sql=select * from ayj_technician where tech_number='%@'"
#endif
