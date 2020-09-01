{{/*
Generate TLS certificates for Hubble server and Hubble Relay.
*/}}
{{- define "ca.gen-certs" }}
{{- $ca := .ca | default (genCA "hubble-ca.cilium.io" 1095) -}}
{{- $_ := set . "ca" $ca -}}
tls.crt: {{ $ca.Cert | b64enc }}
tls.key: {{ $ca.Key | b64enc }}
{{- end }}
{{- define "ca.gen-cert-only" }}
{{- $ca := .ca | default (genCA "hubble-ca.cilium.io" 1095) -}}
{{- $_ := set . "ca" $ca -}}
tls.crt: |-
{{ $ca.Cert | indent 2 -}}
{{- end }}
{{- define "server.gen-certs" }}
{{- $ca := .ca | default (genCA "hubble-ca.cilium.io" 1095) -}}
{{- $_ := set . "ca" $ca -}}
{{- $cert := genSignedCert "*.hubble-grpc.cilium.io" nil (list "*.hubble-grpc.cilium.io") 1095 $ca -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
{{- end }}
{{- define "relay.gen-certs" }}
{{- $ca := .ca | default (genCA "hubble-ca.cilium.io" 1095) -}}
{{- $_ := set . "ca" $ca -}}
{{- $cert := genSignedCert "*.hubble-relay.cilium.io" nil (list "*.hubble-relay.cilium.io") 1095 $ca -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
{{- end }}
