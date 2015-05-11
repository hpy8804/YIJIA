//
//  httpConfigure.h
//  YIJIa
//
//  Created by sven on 3/24/15.
//  Copyright (c) 2015 sven@abovelink. All rights reserved.
//

#ifndef YIJIa_httpConfigure_h
#define YIJIa_httpConfigure_h

#define k_WeakSelf __weak __typeof(&*self)weakSelf = self;

#define kUserName @"login_userName"
#define kUserPassword @"login_userPassword"
#define kTech_Number @"TECH_NUMBER"

#define kTimeoutCount 2.0f

//登录
#define kLoginURL @"http://www.meiyanmeijia.com/backend_service/ibeauty/login.do"

//查询下单历史
#define kHistoryListURL @"http://www.meiyanmeijia.com/backend_service/ibeauty/listOrders.do"

//查询美容师信息
#define kTechInfoURL @"http://www.meiyanmeijia.com/backend_service/ibeauty/getBeauty.do"

//获取头像
#define kTechPortrait @"http://www.meiyanmeijia.com/wx/aiyijia/tech-image.jsp"

//查询评论
#define kComment(_order_id) [NSString stringWithFormat:@"%@/standInterface/queryOne.do?sql=select * from ayj_user_comment where order_id='%@'", kBaseURL, _order_id]

#define kTechnician_info(_techNO) [NSString stringWithFormat:@"%@/getBeauty.do?techNumber=%@", kBaseURL, _techNO]

//查询排班
#define kTechTimeURL @"http://www.meiyanmeijia.com/backend_service/ibeauty/getRestAndSubscribeTime.do"

//修改排班
#define kModefy_technician_time(_name, _week, _changeValue) [NSString stringWithFormat:@"%@/standInterface/updateBatch.do?sql0=delete from ayj_technician_rest where tech_number = '%@' and week =%d;&sql1=INSERT INTO ayj_technician_rest (start_time,tech_number,week) VALUES %@", kBaseURL, _name, _week, _changeValue]
#endif
