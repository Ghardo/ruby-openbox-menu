#!/usr/bin/env ruby
$VERBOSE = nil

require 'rubygems'
require 'nokogiri'

class OpenboxMenu

	def initialize()
		@doc = Nokogiri::XML('<openbox_pipe_menu></openbox_pipe_menu>')
		@menu = Hash.new
		@items = Hash.new
	end

	def menu(label, menuid, rootmenuid = nil)
		@menu[menuid] = self._create_node "menu"
		@menu[menuid]['id'] = menuid
		@menu[menuid]['label'] = label

		if rootmenuid != nil
			@menu[rootmenuid].add_child(@menu[menuid])
		else
			@doc.root.add_child(@menu[menuid])
		end
	end

	def item(itemid, itemlabel, menuid = nil)
		@items[itemid] = self._create_node "item"
		@items[itemid]['label'] = itemlabel

		if menuid == nil
		  @doc.root.add_child(@items[itemid])
		else
		  @menu[menuid].add_child(@items[itemid])
		end
	end

	def separator(label, menuid = nil)
		sep = self._create_node "separator"
		sep['label'] = label

		if menuid != nil
			@menu[menuid].add_child(sep)
		else
			@doc.root.add_child(sep)
		end
	end

	def execute(itemid, command)
		action = self._create_node "action"
		action['name'] = 'Execute'
		execute = self._create_node "execute"
		execute.content = command
		action.add_child(execute)

		@items[itemid].add_child(action)
	end

	def showmenu(itemid, menuid)
		action = self._create_node "action"
		action['name'] = 'ShowMenu'
		menu = self._create_node "menu"
		menu.content = menuid
		action.add_child(menu)

		@items[itemid].add_child(action)
	end

	def getXml
		return @doc.root.to_xml
	end

	protected
	def _create_node(name)
		return Nokogiri::XML::Node.new(name, @doc)
	end
end
