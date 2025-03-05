{{/* vim: set filetype=mustache: */}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define ".helpers_override.fullname" -}}
{{- $name := default .Chart.Name .Release.Name -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define ".helpers_override.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define ".helpers_override.labels" -}}
{{- $values := ( index .Values "ecs-etds" ) -}}
helm.sh/chart: {{ include ".helpers_override.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
argocd.argoproj.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
sid: {{ $values.sid  }}
{{- end -}}

{{- define ".helpers_override.resourceLabels" -}}
{{- $values := ( index .Values "ecs-etds" ) -}}
sid: {{ $values.sid  }}
{{- if $values.customLabels }}
{{ toYaml $values.customLabels }}
{{- end }}
{{- end -}}

{{- define ".helpers_override.backupSecrets"  -}}
{{- $values := ( index .Values "ecs-etds" ) -}}
{{- if $values.backupSecrets }}
velero.io/exclude-from-backup: "false"
{{- else -}}
velero.io/exclude-from-backup: "true"
{{- end -}}
{{- end -}}
