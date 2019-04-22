#!/bin/bash

# TODO: Move to playbook
cfssl gencert -initca ca-csr.json | cfssljson -bare ca
