# Opifex.Heureka.coffee
#
#	© 2014 Dave Goehrig <dave@dloh.org>
#

config = require "#{process.env.HOME}/.heurekarc"
heureka = require 'heureka'

module.exports = () ->
	self = this
	self["list"] = (domain) ->
		console.log "list #{domain}"
		heureka("list",domain, (data) -> self.send ["heureka", "list", data ])
	self["create"] = (domain) ->
		heureka("add","domain",domain)
		heureka("add","soa",domain)
		self.send [ 'heureka', 'create', domain ]
		console.log "create #{domain}"
	self["add"] = (domain,type,host,content) ->
		console.log "add #{domain} #{type} #{host} #{content}"
		heureka("add",domain,type,host,content)
		self.send [ 'heureka', 'add', domain, type, host, content ]
	self["remove"] = (domain,type,host,content) ->
		console.log "remove #{domain} #{type} #{host} #{content}"
		heureka("remove",domain,type,host,content)
		self.send [ 'heureka', 'remove', domain, type, host, content ]
	self["*"] = (message...) ->
		console.log "Unknown message #{ JSON.stringify(message) }"
