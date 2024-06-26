local redis = import '../../../base/redis.libsonnet';
local const = import '../const.libsonnet';

redis.serviceDef(
  region=const.region,
  subnetIDs=const.publicSubnetIDs,
  securityGroupID='sg-0ab649652e2dd6c9c',  // dreamkast-dev-ecs-redis
  serviceDiscoveryID=const.serviceDiscovery.redis,
)
