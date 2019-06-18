resource "helm_release" "prometheus" {
  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository
  version    = var.chart_version
  namespace  = var.chart_namespace

  values = [
    data.template_file.general.rendered,
    data.template_file.alertmanager.rendered,
    data.template_file.kube_state_metrics.rendered,
    data.template_file.node_exporter.rendered,
    data.template_file.pushgateway.rendered,
    data.template_file.server.rendered,
  ]
}

data "template_file" "general" {
  template = file("${path.module}/templates/general.yaml")

  vars = {
    image_pull_secrets = jsonencode(var.image_pull_secrets)

    configmap_name              = var.configmap_name
    configmap_image_repo        = var.configmap_image_repo
    configmap_image_tag         = var.configmap_image_tag
    configmap_image_pull_policy = var.configmap_pull_policy

    configmap_extra_args    = jsonencode(var.configmap_extra_args)
    configmap_extra_volumes = jsonencode(var.configmap_extra_volumes)
    configmap_resources     = jsonencode(var.configmap_resources)

    init_chown_enabled     = var.init_chown_enabled
    init_chown_name        = var.init_chown_name
    init_chown_image_repo  = var.init_chown_image_repo
    init_chown_image_tag   = var.init_chown_image_tag
    init_chown_pull_policy = var.init_chown_pull_policy
    init_chown_resources   = jsonencode(var.init_chown_resources)

    extra_scrape_configs  = jsonencode(var.extra_scrape_configs)
    enable_network_policy = var.enable_network_policy

    alertmanager_service_account       = var.alertmanager_service_account
    kube_state_metrics_service_account = var.kube_state_metrics_service_account
    node_exporter_service_account      = var.node_exporter_service_account
    pushgateway_service_account        = var.pushgateway_service_account
    server_service_account             = var.server_service_account
  }
}

data "template_file" "alertmanager" {
  template = file("${path.module}/templates/alertmanager.yaml")

  vars = {
    enable = var.alertmanager_enable

    repository  = var.alertmanager_repository
    tag         = var.alertmanager_tag
    pull_policy = var.alertmanager_pull_policy

    replica   = var.alertmanager_replica
    resources = jsonencode(var.alertmanager_resources)

    annotations   = jsonencode(var.alertmanager_annotations)
    tolerations   = jsonencode(var.alertmanager_tolerations)
    node_selector = jsonencode(var.alertmanager_node_selector)
    affinity      = jsonencode(var.alertmanager_affinity)

    security_context = coalesce(
      var.alertmanager_security_context_json,
      jsonencode(var.alertmanager_security_context),
    )

    priority_class_name = var.alertmanager_priority_class_name
    extra_args          = jsonencode(var.alertmanager_extra_args)
    extra_env           = jsonencode(var.alertmanager_extra_env)

    prefix_url = var.alertmanager_prefix_url
    base_url   = var.alertmanager_base_url

    config_map_override_name = var.alertmanager_config_map_override_name
    config_from_secret       = var.alertmanager_config_from_secret
    config_file_name         = var.alertmanager_config_file_name

    headless_annotations = jsonencode(var.alertmanager_headless_annotations)
    headless_labels      = jsonencode(var.alertmanager_headless_labels)

    service_annotations      = jsonencode(var.alertmanager_service_annotations)
    service_labels           = jsonencode(var.alertmanager_service_labels)
    service_cluster_ip       = jsonencode(var.alertmanager_service_cluster_ip)
    service_external_ips     = jsonencode(var.alertmanager_service_external_ips)
    service_lb_ip            = jsonencode(var.alertmanager_service_lb_ip)
    service_lb_source_ranges = jsonencode(var.alertmanager_service_lb_source_ranges)
    service_port             = var.alertmanager_service_port
    service_type             = var.alertmanager_service_type

    ingress_enabled      = var.alertmanager_ingress_enabled
    ingress_annotations  = jsonencode(var.alertmanager_ingress_annotations)
    ingress_extra_labels = jsonencode(var.alertmanager_ingress_extra_labels)
    ingress_hosts        = jsonencode(var.alertmanager_ingress_hosts)
    ingress_tls          = jsonencode(var.alertmanager_ingress_tls)

    pv_enabled        = var.alertmanager_pv_enabled
    pv_access_modes   = jsonencode(var.alertmanager_pv_access_modes)
    pv_annotations    = jsonencode(var.alertmanager_pv_annotations)
    pv_existing_claim = var.alertmanager_pv_existing_claim
    pv_size           = var.alertmanager_pv_size

    alertmanager_files = indent(2, var.alertmanager_files)
  }
}

data "template_file" "kube_state_metrics" {
  template = file("${path.module}/templates/kube_state_metrics.yaml")

  vars = {
    enable = var.kube_state_metrics_enable

    repository  = var.kube_state_metrics_repository
    tag         = var.kube_state_metrics_tag
    pull_policy = var.kube_state_metrics_pull_policy

    replica   = var.kube_state_metrics_replica
    resources = jsonencode(var.kube_state_metrics_resources)

    annotations   = jsonencode(var.kube_state_metrics_annotations)
    tolerations   = jsonencode(var.kube_state_metrics_tolerations)
    labels        = jsonencode(var.kube_state_metrics_labels)
    node_selector = jsonencode(var.kube_state_metrics_node_selector)

    security_context = coalesce(
      var.kube_state_metrics_security_context_json,
      jsonencode(var.kube_state_metrics_security_context),
    )

    priority_class_name = var.kube_state_metrics_priority_class_name
    extra_args          = jsonencode(var.kube_state_metrics_extra_args)

    service_annotations      = jsonencode(var.kube_state_metrics_service_annotations)
    service_labels           = jsonencode(var.kube_state_metrics_service_labels)
    service_cluster_ip       = jsonencode(var.kube_state_metrics_service_cluster_ip)
    service_external_ips     = jsonencode(var.kube_state_metrics_service_external_ips)
    service_lb_ip            = jsonencode(var.kube_state_metrics_service_lb_ip)
    service_lb_source_ranges = jsonencode(var.kube_state_metrics_service_lb_source_ranges)
    service_port             = var.kube_state_metrics_service_port
    service_type             = var.kube_state_metrics_service_type
  }
}

data "template_file" "node_exporter" {
  template = file("${path.module}/templates/node_exporter.yaml")

  vars = {
    enable = var.node_exporter_enable

    host_network = var.node_exporter_host_network
    host_pid     = var.node_exporter_host_pid

    repository  = var.node_exporter_repository
    tag         = var.node_exporter_tag
    pull_policy = var.node_exporter_pull_policy

    enable_pod_security_policy      = var.node_exporter_enable_pod_security_policy
    pod_security_policy_annotations = jsonencode(var.node_exporter_pod_security_policy_annotations)

    replica   = var.node_exporter_replica
    resources = jsonencode(var.node_exporter_resources)

    annotations   = jsonencode(var.node_exporter_annotations)
    tolerations   = jsonencode(var.node_exporter_tolerations)
    labels        = jsonencode(var.node_exporter_labels)
    node_selector = jsonencode(var.node_exporter_node_selector)

    security_context = coalesce(
      var.node_exporter_security_context_json,
      jsonencode(var.node_exporter_security_context),
    )

    host_path_mounts  = jsonencode(var.node_exporter_host_path_mounts)
    config_map_mounts = jsonencode(var.node_exporter_config_map_mounts)

    priority_class_name = var.node_exporter_priority_class_name
    extra_args          = jsonencode(var.node_exporter_extra_args)

    service_annotations      = jsonencode(var.node_exporter_service_annotations)
    service_labels           = jsonencode(var.node_exporter_service_labels)
    service_cluster_ip       = jsonencode(var.node_exporter_service_cluster_ip)
    service_external_ips     = jsonencode(var.node_exporter_service_external_ips)
    service_lb_ip            = jsonencode(var.node_exporter_service_lb_ip)
    service_lb_source_ranges = jsonencode(var.node_exporter_service_lb_source_ranges)
    service_port             = var.node_exporter_service_port
    service_type             = var.node_exporter_service_type
  }
}

data "template_file" "pushgateway" {
  template = file("${path.module}/templates/pushgateway.yaml")

  vars = {
    enable = var.pushgateway_enable

    repository  = var.pushgateway_repository
    tag         = var.pushgateway_tag
    pull_policy = var.pushgateway_pull_policy

    replica   = var.pushgateway_replica
    resources = jsonencode(var.pushgateway_resources)

    annotations   = jsonencode(var.pushgateway_annotations)
    tolerations   = jsonencode(var.pushgateway_tolerations)
    node_selector = jsonencode(var.pushgateway_node_selector)

    security_context = coalesce(
      var.pushgateway_security_context_json,
      jsonencode(var.pushgateway_security_context),
    )

    priority_class_name = var.pushgateway_priority_class_name
    extra_args          = jsonencode(var.pushgateway_extra_args)
    extra_env           = jsonencode(var.pushgateway_extra_env)

    service_annotations      = jsonencode(var.pushgateway_service_annotations)
    service_labels           = jsonencode(var.pushgateway_service_labels)
    service_cluster_ip       = jsonencode(var.pushgateway_service_cluster_ip)
    service_external_ips     = jsonencode(var.pushgateway_service_external_ips)
    service_lb_ip            = jsonencode(var.pushgateway_service_lb_ip)
    service_lb_source_ranges = jsonencode(var.pushgateway_service_lb_source_ranges)
    service_port             = var.pushgateway_service_port
    service_type             = var.pushgateway_service_type

    ingress_enabled      = var.pushgateway_ingress_enabled
    ingress_annotations  = jsonencode(var.pushgateway_ingress_annotations)
    ingress_extra_labels = jsonencode(var.pushgateway_ingress_extra_labels)
    ingress_hosts        = jsonencode(var.pushgateway_ingress_hosts)
    ingress_tls          = jsonencode(var.pushgateway_ingress_tls)

    pv_enabled        = var.pushgateway_pv_enabled
    pv_access_modes   = jsonencode(var.pushgateway_pv_access_modes)
    pv_annotations    = jsonencode(var.pushgateway_pv_annotations)
    pv_existing_claim = var.pushgateway_pv_existing_claim
    pv_size           = var.pushgateway_pv_size
  }
}

data "template_file" "server" {
  template = file("${path.module}/templates/server.yaml")

  vars = {
    repository  = var.server_repository
    tag         = var.server_tag
    pull_policy = var.server_pull_policy

    sidecar_containers = jsonencode(var.server_sidecar_containers)

    replica   = var.server_replica
    resources = jsonencode(var.server_resources)

    annotations   = jsonencode(var.server_annotations)
    tolerations   = jsonencode(var.server_tolerations)
    node_selector = jsonencode(var.server_node_selector)
    affinity      = jsonencode(var.server_affinity)

    security_context = coalesce(
      var.server_security_context_json,
      jsonencode(var.server_security_context),
    )

    statefulset_annotations   = jsonencode(var.server_statefulset_annotations)
    termination_grace_seconds = var.server_termination_grace_seconds

    prefix_url = var.server_prefix_url
    base_url   = var.server_base_url

    priority_class_name = var.server_priority_class_name
    extra_args          = jsonencode(var.server_extra_args)
    extra_env           = jsonencode(var.server_extra_env)
    extra_volume_mounts = jsonencode(var.server_extra_volume_mounts)

    extra_volumes          = jsonencode(var.server_extra_volumes)
    extra_host_path_mounts = jsonencode(var.server_extra_host_path_mounts)
    extra_configmap_mounts = jsonencode(var.server_extra_configmap_mounts)
    extra_secret_mounts    = jsonencode(var.server_extra_secret_mounts)

    headless_annotations = jsonencode(var.server_headless_annotations)
    headless_labels      = jsonencode(var.server_headless_labels)

    service_annotations      = jsonencode(var.server_service_annotations)
    service_labels           = jsonencode(var.server_service_labels)
    service_cluster_ip       = jsonencode(var.server_service_cluster_ip)
    service_external_ips     = jsonencode(var.server_service_external_ips)
    service_lb_ip            = jsonencode(var.server_service_lb_ip)
    service_lb_source_ranges = jsonencode(var.server_service_lb_source_ranges)
    service_port             = var.server_service_port
    service_type             = var.server_service_type

    ingress_enabled      = var.server_ingress_enabled
    ingress_annotations  = jsonencode(var.server_ingress_annotations)
    ingress_extra_labels = jsonencode(var.server_ingress_extra_labels)
    ingress_hosts        = jsonencode(var.server_ingress_hosts)
    ingress_tls          = jsonencode(var.server_ingress_tls)

    pv_enabled        = var.server_pv_enabled
    pv_access_modes   = jsonencode(var.server_pv_access_modes)
    pv_annotations    = jsonencode(var.server_pv_annotations)
    pv_existing_claim = var.server_pv_existing_claim
    pv_size           = var.server_pv_size

    enable_admin_api    = var.server_enable_admin_api
    skip_tsdb_lock      = var.server_skip_tsdb_lock
    scrape_interval     = var.server_scrape_interval
    scrape_timeout      = var.server_scrape_timeout
    evaluation_interval = var.server_evaluation_interval
    retention           = jsonencode(var.server_data_retention)

    alerts        = indent(2, var.server_alerts)
    rules         = indent(2, var.server_rules)
    server_config = indent(2, var.server_config)
  }
}
