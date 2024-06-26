local dreamkast_ui = import '../../../base/dreamkast-ui.libsonnet';
local const = import '../const.libsonnet';

dreamkast_ui.serviceDef(
  region=const.region,
  subnetIDs=const.publicSubnetIDs,
  securityGroupID='sg-026faf401f03b7bd4',  // dreamkast-dev-ecs-dreamkast-ui
  targetGroupArn=const.targetGroupArn.dkUi,
)
