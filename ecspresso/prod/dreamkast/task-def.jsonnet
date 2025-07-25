local dreamkast = import '../../base/dreamkast.libsonnet';
local otelcol_config = importstr './files/otelcol-config.yaml';
local const = import '../const.libsonnet';

dreamkast.taskDef(
  family='dreamkast-prod-dk',
  cpu=1024,
  memory=2048,
  taskRoleName='dreamkast-prod-ecs-dreamkast',
  executionRoleName=const.executionRoleName,
  imageTag=const.imageTags.dreamkast_ecs,

  region=const.region,
  dkApiEndpoint=const.externalEndpoints.dkApi,
  dkWeaverEndpoint=const.externalEndpoints.dkWeaver,
  rdbInternalEndpoint=const.internalEndpoints.rdb,
  redisInternalEndpoint=const.internalEndpoints.redis,

  s3BucketName=const.s3.dreamkast.name,
  s3BucketRegion=const.s3.dreamkast.region,

  sqsFifoQueueName=const.sqs.fifo,

  sentryDsn=const.sentry.dsn,

  railsAppSecretManagerName=const.secretManager.railsApp,
  rdsSecretManagerName=const.secretManager.rds,
  dreamkastSecretManagerName=const.secretManager.dk,

  enableLogging=false,

  enableLokiLogging=true,
  lokiEndpoint=const.externalEndpoints.loki,

  enableMackerelSidecar=false,
  mackerelSecretManagerName=const.secretManager.mackerel,
  mackerelRoles='dreamkast-prod:app',

  enableOtelcolSidecar=false,
  otelcolConfig=otelcol_config,
)
