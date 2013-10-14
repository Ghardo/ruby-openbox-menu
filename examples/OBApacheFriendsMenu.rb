#!/usr/bin/env ruby
require 'openboxmenu'

XAMPP="/opt/lampp/lampp"
CONSOLE="/usr/bin/urxvt -e bash -c "

status = %x{#{XAMPP} status}.split(/\n/)

obm = OpenboxMenu.new
obm.separator('Apachefriends XAMPP OB Menu')

obm.item('main_start', '_b Start')
obm.execute('main_start', "#{CONSOLE} 'sudo /opt/lampp/lampp start && sleep 1'")

obm.item('main_stop', '_e Stop')
obm.execute('main_stop', "#{CONSOLE} 'sudo /opt/lampp/lampp stop && sleep 1'")

obm.item('main_reload', 'Reload')
obm.execute('main_reload', "#{CONSOLE} 'sudo /opt/lampp/lampp reload && sleep 1'")

obm.item('main_restart', '_r Restart')
obm.execute('main_restart', "#{CONSOLE} 'sudo /opt/lampp/lampp restart && sleep 1'")

obm.separator('Apache')
if status[1] =~ /not running/
  obm.item('apache_start', '_1 Start')
  obm.execute('apache_start', "#{CONSOLE} 'sudo /opt/lampp/lampp startapache && sleep 1'")
else
  obm.item('apache_stop', '_1 Stop')
  obm.execute('apache_stop', "#{CONSOLE} 'sudo /opt/lampp/lampp stopapache && sleep 1'")
end

obm.item('apache_reload', '_a Restart')
obm.execute('apache_reload', "#{CONSOLE} 'sudo /opt/lampp/lampp reloadapache && sleep 1'")

obm.separator('MySQL')
if status[2] =~ /not running/
  obm.item('mysql_start', '_2 Start')
  obm.execute('mysql_start', "#{CONSOLE} 'sudo /opt/lampp/lampp startmysql && sleep 1'")
else
  obm.item('mysql_stop', '_2 Stop')
  obm.execute('mysql_stop', "#{CONSOLE} 'sudo /opt/lampp/lampp stopmysql && sleep 1'")
end

obm.item('mysql_reload', '_m Restart')
obm.execute('mysql_reload', "#{CONSOLE} 'sudo /opt/lampp/lampp reloadmysql && sleep 1'")

obm.separator('ProFTPD')
if status[3] =~ /not running/
  obm.item('ftp_start', '_3 Start')
  obm.execute('ftp_start', "#{CONSOLE} 'sudo /opt/lampp/lampp startftp && sleep 1'")
else
  obm.item('ftp_stop', '_3 Stop')
  obm.execute('ftp_stop', "#{CONSOLE} 'sudo /opt/lampp/lampp stopftp && sleep 1'")
end

obm.item('ftp_reload', '_p Restart')
obm.execute('ftp_reload', "#{CONSOLE} 'sudo /opt/lampp/lampp reloadftp && sleep 1'")

obm.separator(status[0])

puts obm.getXml