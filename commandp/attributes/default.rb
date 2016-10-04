#
# Cookbook Name:: commandp
# Attribute:: default
#
# Copyright 2012, Jimmy Kuo
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

default[:notify][:deploy][:start]      = "左線預備、右線預備、全線預備~~~~~~~~~ 開始 Deploy ！！"
default[:notify][:deploy][:finished]   = "悄悄的我走了，正如我悄悄的 Deploy 了，那個誰誰誰測試就交給你了！"
default[:notify][:slack][:webhook_url] = ''
default[:notify][:slack][:channel]     = '#general'
default[:notify][:slack][:username]    = 'AWS OpsWorks'
default[:notify][:slack][:icon_url]    = 'http://i.imgur.com/XhD7DuC.png'
default[:node_version]                 = '0.12.2'
