{
  externalEndpoints: {
    dk: 'https://event.cloudnativedays.jp',
    dkApi: 'https://api.cloudnativedays.jp',
    dkWeaver: 'https://dkw.cloudnativedays.jp',
    loki: 'https://loki.cloudnativedays.jp',
  },
  imageTags: {
    dreamkast_ecs: 'v4.10.0',
    dreamkast_ui: 'v2.11.4',
    dreamkast_weaver: 'a9098f1b97369e39d4220b661e96e031131642a9',  // v0.2.3
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
  },
  sentry: {
    dsn: 'https://ec7eb42486bea4e950a48ef1c943510c@sentry.cloudnativedays.jp/2',
  },
  serviceDiscovery: {
    dk: 'srv-x5wza5r7otdcwmt3',
  },
  sqs: {
    fifo: 'dreamkast-prod-fifo-queue',
    mail: 'dreamkast-prod-mail-queue',
  },
}
