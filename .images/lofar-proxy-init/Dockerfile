FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
        gnupg2 \
        voms-clients \
        wget

RUN echo "deb [trusted=yes] http://repository.egi.eu/sw/production/cas/1/current egi-igtf core" >> /etc/apt/sources.list \
 && wget -q -O - http://repository.egi.eu/sw/production/cas/1/current/GPG-KEY-EUGridPMA-RPM-3 | apt-key add -

RUN apt-get update && apt-get install -y \
        ca-policy-egi-core \
        fetch-crl \
 && rm -rf /var/lib/apt/lists/*

RUN echo '"lofar" "voms.grid.sara.nl" "30019" "/O=dutchgrid/O=hosts/OU=sara.nl/CN=voms.grid.sara.nl" "lofar"' > /var/local/lofar.vo
RUN echo '/O=dutchgrid/O=hosts/OU=sara.nl/CN=voms.grid.sara.nl\n/C=NL/O=NIKHEF/CN=NIKHEF medium-security certification auth' > /var/local/voms.grid.sara.nl.lsc

RUN fetch-crl \
 && mkdir /wd \
 && mkdir -p /etc/grid-security/vomsdir/lofar \
 && mv /var/local/voms.grid.sara.nl.lsc /etc/grid-security/vomsdir/lofar \
 && mkdir -p /etc/vomses \
 && mv /var/local/lofar.vo /etc/vomses

COPY ./entrypoint.sh            /

ENTRYPOINT [ "/entrypoint.sh" ] 