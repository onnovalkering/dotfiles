#!/usr/bin/env sh
export X509_USER_CERT=/globus/usercert.pem
export X509_USER_KEY=/globus/userkey.pem
export X509_USER_PROXY=/globus/proxy

voms-proxy-init -voms lofar:/lofar/user $@