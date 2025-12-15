{{- define "lldap.certmanager.volumes" -}}
{{- if .Values.certmanager.enabled }}
- name: certificate-volume
  secret:
    secretName: {{ include "lldap.fullname" . }}-tls
{{- end }}
{{- end }}

{{- define "lldap.certmanager.volumeMounts" -}}
{{- if .Values.certmanager.enabled }}
- name: certificate-volume
  mountPath: /certificate
{{- end }}
{{- end }}

{{- define "lldap.certmanager.env" -}}
- name: LLDAP_LDAPS_OPTIONS__CERT_FILE
  value: /certificate/tls.crt
- name: LLDAP_LDAPS_OPTIONS__KEY_FILE
  value: /certificate/tls.key
{{- end }}
