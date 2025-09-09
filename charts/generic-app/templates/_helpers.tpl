{{- define "generic-app.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "generic-app.fullname" -}}
{{ include "generic-app.name" . }}-{{ .Release.Name }}
{{- end }}
