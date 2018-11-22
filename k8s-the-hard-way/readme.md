Example usage:

`
ansible-playbook provision_ca_and_gen_tls_cert.yaml -e cluster_size=1mc-1mc
`

See/Validate generated cert:

`
$ openssl x509 -in ca.pem -text -noout
`