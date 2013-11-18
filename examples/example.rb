#!/usr/bin/env ruby
require 'openboxmenu'

obm = OpenboxMenu.new
obm.separator('Title Root')

obm.menu('_1 Menu 1', 'menu1')
obm.menu('_2 Menu 2', 'menu2')

obm.item("m1_menu1", "Menu 1 Item 1", 'menu1')
obm.item("m1_menu2", "Open Device Menu", 'menu1')
obm.item("m2_menu1", "Menu 2 Item 1", 'menu2')
obm.item("m2_menu2", "Menu 2 Menu 1", 'menu2')
obm.menu('_1 Menu 3', 'menu3', 'menu2')
obm.item("m3_menu1", "Menu 3 Item 1", 'menu3')

puts obm.getXml
