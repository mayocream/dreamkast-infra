local mysql = import '../../../base/mysql.libsonnet';
local const = import '../const.libsonnet';

mysql.taskDef(
  family='dreamkast-dev-%s-mysql' % [const.PR_NAME],
  taskRoleName='dreamkast-dev-ecs-mysql',
  imageTag=const.imageTags.mysql,

  region=const.region,

  enableLogging=false,
)
