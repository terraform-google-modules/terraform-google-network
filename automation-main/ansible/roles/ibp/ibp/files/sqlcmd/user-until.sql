select USER_NAME, to_varchar(PASSWORD_CHANGE_TIME, 'YYYY-MM-DD') as Start_date, to_varchar(valid_until, 'YYYY-MM-DD') as EXPIRE_DATE from  users
where
VALID_UNTIL<add_days(CURRENT_DATE,14) ;
