FROM python:3 as builder

SHELL ["/bin/bash", "-xeuo", "pipefail", "-c"]
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python - \
    && ln -s "$HOME/.poetry/bin/poetry" /usr/local/bin/poetry \
    && mkdir -p /usr/local/build

WORKDIR /usr/local/build
COPY pyproject.toml poetry.lock ./
COPY third_party ./third_party/
RUN poetry export -f requirements.txt -o requirements.txt --without-hashes

WORKDIR /usr/local/hello-world/
COPY . /usr/local/hello-world/
RUN rm -rf third_party

FROM python:3

COPY --from=builder /usr/local/build/ /usr/local/build/
RUN pip3 install --no-cache-dir -r /usr/local/build/requirements.txt \
    && rm -rf /usr/local/build ~/.cache/pip

WORKDIR /usr/local/hello-world/
COPY --from=builder /usr/local/hello-world /usr/local/hello-world/

ENTRYPOINT [ "ipython" ]
