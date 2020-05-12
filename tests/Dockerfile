FROM wata727/tflint:0.15.5

ARG TERRAFORM_VERSION=0.12.24

RUN apk add --no-cache curl git \
  && curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform.zip \
  && unzip terraform.zip \
  && rm -fr terraform.zip \
  && mv terraform /usr/local/bin

# Awaiting release of https://github.com/terraform-providers/terraform-provider-kubernetes/pull/817
RUN mkdir -p /root/.terraform.d/plugins \
  && curl -L https://github.com/lawliet89/terraform-provider-kubernetes/releases/download/csi-2020-05-12/terraform-provider-kubernetes -o "/root/.terraform.d/plugins/terraform-provider-kubernetes_v1.12.0" \
  && chmod +x /root/.terraform.d/plugins/terraform-provider-kubernetes_v1.12.0 \
  && ls -alh /root/.terraform.d/plugins

COPY tests/lint /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/lint"]

WORKDIR /data
COPY . /data
