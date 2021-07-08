# multistage-dockefile-demo
Clone this repository, and then run `docker-compose build` followed by `docker-compose run`.

You should be able to see something like this:
```console
$ docker-compose build
Building hello-world
[+] Building 18.3s (18/18) FINISHED                                                                                                              
 => [internal] load build definition from Dockerfile                                                                                        0.0s
 => => transferring dockerfile: 44B                                                                                                         0.0s
 => [internal] load .dockerignore                                                                                                           0.0s
 => => transferring context: 2B                                                                                                             0.0s
 => [internal] load metadata for docker.io/library/python:3                                                                                 1.4s
 => [internal] load build context                                                                                                           0.0s
 => => transferring context: 12.99kB                                                                                                        0.0s
 => CACHED [builder 1/9] FROM docker.io/library/python:3@sha256:22d67fbf4849f06491933f273526e425342b210e9c8b90052708c09a00f6154f            0.0s
 => [builder 2/9] RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -     && ln -s "$HOME  8.8s
 => [builder 3/9] WORKDIR /usr/local/build                                                                                                  0.0s
 => [builder 4/9] COPY pyproject.toml poetry.lock ./                                                                                        0.0s
 => [builder 5/9] COPY third_party ./third_party/                                                                                           0.0s
 => [builder 6/9] RUN poetry export -f requirements.txt -o requirements.txt --without-hashes                                                1.6s
 => [builder 7/9] WORKDIR /usr/local/hello-world/                                                                                           0.0s 
 => [builder 8/9] COPY . /usr/local/hello-world/                                                                                            0.0s 
 => [builder 9/9] RUN rm -rf third_party                                                                                                    0.2s
 => [stage-1 2/5] COPY --from=builder /usr/local/build/ /usr/local/build/                                                                   0.0s
 => [stage-1 3/5] RUN pip3 install --no-cache-dir -r /usr/local/build/requirements.txt     && rm -rf /usr/local/build ~/.cache/pip          5.5s
 => [stage-1 4/5] WORKDIR /usr/local/hello-world/                                                                                           0.0s
 => [stage-1 5/5] COPY --from=builder /usr/local/hello-world /usr/local/hello-world/                                                        0.0s
 => exporting to image                                                                                                                      0.4s
 => => exporting layers                                                                                                                     0.4s
 => => writing image sha256:3432fda263b67f79beec305978962acbcccbb8b12148034400c11c85a5780743                                                0.0s
 => => naming to docker.io/library/multistage-dockerfile-demo_hello-world                                                                   0.0s

$ docker-compose run hello-world 
Creating multistage-dockerfile-demo_hello-world_run ... done
Python 3.9.6 (default, Jun 29 2021, 19:18:53) 
Type 'copyright', 'credits' or 'license' for more information
IPython 7.25.0 -- An enhanced Interactive Python. Type '?' for help.

In [1]: import hello_world

In [2]: 
```