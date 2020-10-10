import sys,os
os.chdir("/www/server/panel/")
sys.path.append("/www/server/panel/class/")
import public,db

username = 'admin2'
password = 'admin1'

sql = db.Sql()
#sql.table('users').where('id=?',(1,)).setField('password',public.md5(password))
#sql.table('users').where('id=?',(1,)).setField('password',public.password_salt(public.md5(password),uid=1))
#sql.table('users').where('id=?',(1,)).setField('username',username)
result = sql.table('users').where('id=?',(1,)).setField('password',public.password_salt(public.md5(password),uid=1))
username = sql.table('users').where('id=?',(1,)).getField('username')


public.writeFile('data/admin_path.pl', '/')
public.writeFile('default.pl', password)
