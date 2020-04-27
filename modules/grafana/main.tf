resource "helm_release" "grafana" {
  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository
  version    = var.chart_version
  namespace  = var.chart_namespace

  max_history = var.max_history

  values = [
    data.template_file.general.rendered,
  ]
}

data "template_file" "general" {
  template = file("${path.module}/templates/general.yaml")

  vars = {
    replicas          = var.replicas
    image             = var.image
    tag               = var.tag
    image_pull_policy = var.image_pull_policy

    service_account             = var.service_account
    service_account_annotations = jsonencode(var.service_account_annotations)

    run_as_user = var.run_as_user
    fs_group    = var.fs_group
    psp_enable  = var.psp_enable
    pdb         = jsonencode(var.pdb)
    command     = jsonencode(var.command)

    extra_configmap_mounts = jsonencode(var.extra_configmap_mounts)
    extra_empty_dir_mounts = jsonencode(var.extra_empty_dir_mounts)

    priority_class_name = var.priority_class_name

    pod_annotations = jsonencode(var.pod_annotations)
    annotations     = jsonencode(var.annotations)
    resources       = jsonencode(var.resources)
    node_selector   = jsonencode(var.node_selector)
    tolerations     = jsonencode(var.tolerations)
    affinity        = jsonencode(var.affinity)

    env                 = jsonencode(var.env)
    env_from_secret     = var.env_from_secret
    extra_secret_mounts = jsonencode(var.extra_secret_mounts)
    extra_volume_mounts = jsonencode(var.extra_volume_mounts)

    service_type        = var.service_type
    service_port        = var.service_port
    service_target_port = var.service_target_port
    service_annotations = jsonencode(var.service_annotations)
    service_labels      = jsonencode(var.service_labels)

    ingress_enabled     = var.ingress_enabled
    ingress_annotations = jsonencode(var.ingress_annotations)
    ingress_labels      = jsonencode(var.ingress_labels)
    ingress_hosts       = jsonencode(var.ingress_hosts)
    ingress_tls         = jsonencode(var.ingress_tls)

    extra_init_containers = jsonencode(var.extra_init_containers)
    extra_containers      = jsonencode(var.extra_containers)

    persistence_enabled            = var.persistence_enabled
    persistence_size               = var.persistence_size
    persistence_storage_class_name = var.persistence_storage_class_name
    persistence_annotations        = jsonencode(var.persistence_annotations)
    persistence_existing_claim     = var.persistence_existing_claim

    init_chown_data_enabled   = var.init_chown_data_enabled
    init_chown_data_resources = jsonencode(var.init_chown_data_resources)

    plugins = jsonencode(var.plugins)

    datasources            = indent(2, var.datasources)
    notifiers              = indent(2, var.notifiers)
    dashboard_providers    = indent(2, var.dashboard_providers)
    dashboards             = indent(2, var.dashboards)
    dashboards_config_maps = indent(2, var.dashboards_config_maps)

    main_config = indent(2, var.main_config)

    ldap_existing_secret = var.ldap_existing_secret
    ldap_config          = jsonencode(var.ldap_config)

    smtp_existing_secret = var.smtp_existing_secret
    smtp_user_key        = var.smtp_user_key
    smtp_password_key    = var.smtp_password_key
  }
}
