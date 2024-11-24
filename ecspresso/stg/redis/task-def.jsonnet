local redis = import '../../base/redis.libsonnet';
local const = import '../const.libsonnet';

redis.taskDef(
  family='dreamkast-stg-redis',
  taskRoleName='dreamkast-dev-ecs-redis',
  executionRoleName=const.executionRoleName,
  imageTag=const.imageTags.redis,

  region=const.region,

  enableLogging=false,
)
