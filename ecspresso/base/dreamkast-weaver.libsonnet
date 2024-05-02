local common = import './common.libsonnet';
local const = import './const.libsonnet';

{
  serviceDef(
    region,
    replicas=1,
    subnetIDs=[],
    securityGroupID,
    targetGroupArn,
  )::
    common.serviceDef(
      region,
      replicas,
      subnetIDs,
      securityGroupID,
    ) + {
      healthCheckGracePeriodSeconds: 0,
      loadBalancers: [
        {
          containerName: 'dkw-serve',
          containerPort: 8080,
          targetGroupArn: targetGroupArn,
        },
      ],
    },

  taskDef(
    family,
    taskRoleName,
    imageTag,
    region,
    dkInternalEndpoint,
    rdbInternalEndpoint,
    rdsSecretManagerName,
    enableLogging=false,
  ):: {
    local root = self,
    //
    // Templates
    //
    containerDefinitionCommon:: {
      local containerDefinitionCommon = self,
      name: error 'must be overridden',
      image: '%s.dkr.ecr.%s.amazonaws.com/dreamkast-weaver:%s' % [const.accountID, region, imageTag],
      entryPoint: [],
      command: [],

      cpu: error 'must be overridden',
      memoryReservation: error 'must be overridden',
      essential: false,

      environment: [
        {
          name: 'DB_ENDPOINT',
          value: rdbInternalEndpoint,
        },
        {
          name: 'DB_PORT',
          value: '3306',
        },
        {
          name: 'DREAMKAST_NAMESPACE',
          value: if family == 'dreamkast-prd-ui' then 'dreamkast'
          else if family == 'dreamkast-stg-ui' then 'dreamkast-staging'
          else family,
        },
      ],
      secrets: [
        // from rds-secret Secret
        {
          valueFrom: 'arn:aws:secretsmanager:%s:%s:secret:%s:username::' % [region, const.accountID, rdsSecretManagerName],
          name: 'DB_USER',
        },
        {
          valueFrom: 'arn:aws:secretsmanager:%s:%s:secret:%s:password::' % [region, const.accountID, rdsSecretManagerName],
          name: 'DB_PASSWORD',
        },
      ],

      portMappings: [],
      links: [],
      mountPoints: [],
      volumesFrom: [],
      dependsOn: [],
    },


    //
    // Definitions
    //
    executionRoleArn: 'arn:aws:iam::%s:role/%s' % [const.accountID, const.executionRoleName],
    taskRoleArn: 'arn:aws:iam::%s:role/%s' % [const.accountID, taskRoleName],
    family: family,
    cpu: '256',
    memory: '512',
    networkMode: 'awsvpc',
    requiresCompatibilities: ['FARGATE'],
    volumes: [],
    containerDefinitions: [
      root.containerDefinitionCommon {
        name: 'dkw-dbmigrate',
        entryPoint: ['/dkw', 'dbmigrate'],
        cpu: 32,
        memoryReservation: 64,
      } + if enableLogging then {
        logConfiguration: {
          logDriver: 'awslogs',
          options: {
            'awslogs-group': family,
            'awslogs-create-group': 'true',
            'awslogs-region': region,
            'awslogs-stream-prefix': 'dkw-dbmigrate',
          },
        },
      } else {},
      root.containerDefinitionCommon {
        name: 'dkw-serve',
        entryPoint: ['/dkw', 'serve'],
        command: ['--port=8080'],
        cpu: 224,
        memoryReservation: 448,
        essential: true,
        environment: root.containerDefinitionCommon.environment + [
          {
            name: 'DREAMKAST_ADDR',
            value: dkInternalEndpoint,
          },
          {
            name: 'AWS_REGION',  // IVS REGION
            value: 'us-east-1',
          },
          //{
          //  name: 'PROM_PUSHGATEWAY_ENDPOINT',
          //  value: 'http://prometheus-pushgateway.monitoring.svc.cluster.local:9091',
          //},
        ],
        portMappings: [{
          containerPort: 8080,
          hostPort: 8080,
          protocol: 'tcp',
        }],
        dependsOn: [
          {
            containerName: 'dkw-dbmigrate',
            condition: 'SUCCESS',
          },
        ],
      } + if enableLogging then {
        logConfiguration: {
          logDriver: 'awslogs',
          options: {
            'awslogs-group': family,
            'awslogs-create-group': 'true',
            'awslogs-region': region,
            'awslogs-stream-prefix': 'dkw-serve',
          },
        },
      } else {},
    ],
  },
}
