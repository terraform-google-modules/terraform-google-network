{{/*
Expand the name of the chart.
*/}}
{{- define "sftpgo_override.name" -}}
{{- default .Chart.Name .Values.sftpgo.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sftpgo_override.fullname" -}}
{{- if .Values.sftpgo.fullnameOverride }}
{{- .Values.sftpgo.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.sftpgo.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sftpgo_override.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sftpgo_override.labels" -}}
helm.sh/chart: {{ include "sftpgo_override.chart" . }}
{{ include "sftpgo_override.selectorLabels" . }}
{{- if .Values.sftpgo.image.tag }}
app.kubernetes.io/version: {{ .Values.sftpgo.image.tag | trimPrefix "v" | quote }}
{{- else if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sftpgo_override.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sftpgo_override.name" . }}
app.kubernetes.io/instance: {{ include "sftpgo_override.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sftpgo_override.serviceAccountName" -}}
{{- if .Values.sftpgo.serviceAccount.create }}
{{- default (include "sftpgo_override.fullname" .) .Values.sftpgo.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.sftpgo.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified component name from the full app name and a component name.
We truncate the full name at 63 - 1 (last dash) - len(component name) chars because some Kubernetes name fields are limited to this (by the DNS naming spec)
and we want to make sure that the component is included in the name.

Usage: {{ include "sftpgo_override.componentname" (list . "component") }}
*/}}
{{- define "sftpgo_override.componentname" -}}
{{- $global := index . 0 -}}
{{- $component := index . 1 | trimPrefix "-" -}}
{{- printf "%s-%s" (include "sftpgo_override.fullname" $global | trunc (sub 62 (len $component) | int) | trimSuffix "-" ) $component | trimSuffix "-" -}}
{{- end -}}
