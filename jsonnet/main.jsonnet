// 导入库
local k = import 'vendor/jsonnet-libs/ksonnet-util/kausal.libsonnet';

// 获取外部变量
local env = std.extVar('env');
local namespace = std.extVar('namespace');

// 定义基本组件
local deployment = k.apps.v1.deployment;
local container = k.core.v1.container;
local port = k.core.v1.containerPort;
local service = k.core.v1.service;

// 创建资源
local nginxContainer = 
  container.new('nginx', 'nginx:1.21.0')
  + container.withPorts([port.new('http', 80)]);

local nginxDeployment = 
  deployment.new('nginx', 
    if env == 'prod' then 3 else 1, 
    nginxContainer);

local nginxService = 
  service.new('nginx-service', 
    nginxDeployment.spec.selector.matchLabels, 
    [{port: 80, targetPort: 80}]);

// 返回多个资源
{
  'deployment.yaml': k.core.v1.list.new([nginxDeployment]),
  'service.yaml': k.core.v1.list.new([nginxService]),
} 