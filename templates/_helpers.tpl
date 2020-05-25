{{/* vim: set filetype=mustache: */}}

{{/* Expand the name of the chart. */}}
{{- define "service.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Expand AWS ECR image url. */}}
{{- define "image.url" -}}
{{- $serviceName := default .Release.Name .Values.nameOverride -}}
{{- printf "%s/%s:%s" .Values.deployment.spec.image.repository $serviceName .Values.deployment.spec.image.tag -}}
{{- end -}}

{{- define "ingress.type" -}}
{{- range $key, $label := (lookup "v1" "Namespace" "" .Release.Namespace).metadata.labels }}
{{- if eq $key "ingress" }}
{{- printf "%s" $label -}}
{{- end }}
{{- end }}
{{- end -}}