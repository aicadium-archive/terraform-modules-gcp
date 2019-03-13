FROM google/cloud-sdk:237.0.0

ARG ansible_version=2.7.5
ARG consul_version=1.4.2
ARG vault_version=1.0.3

RUN set -xe \
    && apt-get update \
    && apt-get install -y unzip \
    && pip install "ansible==${ansible_version}" \
    && curl -Lo /tmp/consul.zip "https://releases.hashicorp.com/consul/${consul_version}/consul_${consul_version}_linux_amd64.zip" \
    && unzip -d /usr/local/bin /tmp/consul.zip \
    && rm /tmp/consul.zip \
    && curl -Lo /tmp/vault.zip "https://releases.hashicorp.com/vault/${vault_version}/vault_${vault_version}_linux_amd64.zip" \
    && unzip -d /usr/local/bin /tmp/vault.zip \
    && rm /tmp/vault.zip \
    && ansible --version \
    && consul version \
    && vault --version \
    && gsutil --version

WORKDIR /opt/consul_backup
COPY site.yml ./

CMD ["ansible-playbook", "-i", "localhost," "--connection", "local", "site.yml"]
