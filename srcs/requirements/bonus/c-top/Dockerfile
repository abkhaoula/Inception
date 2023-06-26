FROM debian:buster

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y ca-certificates curl gnupg lsb-release && curl -fsSL https://azlux.fr/repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/azlux-archive-keyring.gpg && echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian \
    $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azlux.list >/dev/null && \
    apt-get update -y && \
    apt-get install docker-ctop wget -y && \
    wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop && \
    chmod +x /usr/local/bin/ctop

# COPY ./tools/run_ctop.sh .

ENTRYPOINT [ "ctop" ]