select USER_NAME, to_varchar(PASSWORD_CHANGE_TIME, 'YYYY-MM-DD') as Start_date, to_varchar(add_days(PASSWORD_CHANGE_TIME, 182), 'YYYY-MM-DD') as expire_date from  users where  PASSWORD_CHANGE_TIME > '' and days_between(to_date(PASSWORD_CHANGE_TIME),current_date)>162;
