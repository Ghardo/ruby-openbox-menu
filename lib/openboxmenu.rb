require 'rubygems'
require 'nokogiri'

class OpenboxMenu
	
	def initialize()
		@doc = Nokogiri::XML('<openbox_pipe_menu></openbox_pipe_menu>')
		@menu = Hash.new
		@items = Hash.new
	end
	
	def menu(menuid, label)
		@menu[menuid] = Nokogiri::XML::Node.new( "menu", @doc )
		@menu[menuid]['id'] = menuid
		@menu[menuid]['label'] = label
		@doc.root.add_child(@menu[menuid])
	end
	
	def item(menuid, itemid, itemlabel)
		@items[itemid] = Nokogiri::XML::Node.new( "item", @doc )
		@items[itemid]['label'] = itemlabel
		@menu[menuid].add_child(@items[itemid])
	end
	
	def execute(itemid, command)
		action = Nokogiri::XML::Node.new( "action", @doc )
		action['name'] = 'Execute'
		execute = Nokogiri::XML::Node.new( "execute", @doc )
		execute.content = command
		action.add_child(execute)
		
		@items[itemid].add_child(action)
	end
	
	def getXml
		return @doc.root.to_xml
	end
end
