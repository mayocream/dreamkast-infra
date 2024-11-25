local const = import '../const.libsonnet';
{
  region: const.region,
  cluster: const.cluster,
  service: 'seaman',
  service_definition: 'service-def.jsonnet',
  task_definition: 'task-def.jsonnet',
  timeout: '10m',
}