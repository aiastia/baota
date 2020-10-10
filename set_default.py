import sys,os
os.chdir("/www/server/panel/")
sys.path.append("/www/server/panel/class/")
import public,db

username = 'admin'
password = 'admin'

sql = db.Sql()
result = sql.table('users').where('id=?',(1,)).setField('password',public.password_salt(public.md5(password),uid=1))
username = sql.table('users').where('id=?',(1,)).getField('username')

public.writeFile('data/admin_path.pl', '/')
public.writeFile('default.pl', password)

