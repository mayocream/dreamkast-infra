{
  cluster: 'dreamkast-prod',
  executionRoleName: 'dreamkast-prod-ecs-task-execution-role',
  externalEndpoints: {
    dk: 'https://event.cloudnativedays.jp',
    dkApi: 'https://api.cloudnativedays.jp',
    dkWeaver: 'https://dkw.cloudnativedays.jp',
    loki: 'https://loki.cloudnativedays.jp',
  },
  imageTags: {
    dreamkast_ecs: 'release-v4.16.0',
    dreamkast_ui: 'release-v2.11.18',
    dreamkast_weaver: 'release-v0.5.2',
    seaman: 'release-v1.0.6',
  },
  internalEndpoints: {
    dk: 'http://dreamkast.production.local',
    rdb: 'dreamkast-prod-rds.c6eparu1hmbv.ap-northeast-1.rds.amazonaws.com',
    redis: 'redis://dreamkast-prod-redis.bp6loy.ng.0001.apne1.cache.amazonaws.com:6379',
  },
  publicSubnetIDs: [
    'subnet-015fd58d325bd5220',
    'subnet-0e49e678a0ba4ad88',
    'subnet-0f77572d3d3153413',
  ],
  region: 'ap-northeast-1',
  s3: {
    dreamkast: {
      name: 'dreamkast-prod-bucket',
      region: 'ap-northeast-1',
    },
  },
  secretManager: {
    dk: 'dreamkast/production-env-DIVwmP',
    dkUi: 'dreamkast-ui/production-env-OEnUAF',
    mackerel: 'dreamkast/mackerel-api-key-zz4Oyb',
    railsApp: 'dreamkast/rails-app-secret-g6fKNJ',
    rds: 'dreamkast-prod-rds-secret-D2cSKm',
    releasebot: 'dreamkast-releasebot-zHsXND',
  },
  sentry: {
    dsn: 'https://3ae606172e0b82cec45c674e905ab233@o414348.ingest.us.sentry.io/4509089530904576',
  },
  serviceDiscovery: {
    dk: 'srv-x5wza5r7otdcwmt3',
  },
  sqs: {
    fifo: 'dreamkast-prod-fifo-queue',
    mail: 'dreamkast-prod-mail-queue',
  },
  taskTargetRoleName: 'dreamkast-prod-ecs-scheduled-task-target-role',
}
