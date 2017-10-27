# Tracers

<div align="center" style="margin-top:20px;">
  <img src="assets/tracer.jpg"/>
</div>

---
## Motivation

 Sample Phoenix applications to demonstrate the use [ExRay](https://github.com/derailed/ex_ray)
 and OpenTracing via [Otter](https://github.com/Bluehouse-Technology/otter)

---
## Up And Running

1. Start Jaeger Docker Image

    ```shell
    docker run -d -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 \
    -p5775:5775/udp -p6831:6831/udp -p6832:6832/udp \
    -p5778:5778 -p16686:16686 -p14268:14268 -p9411:9411 \
    jaegertracing/all-in-one:latest
    ```

1. Start TraceMe Phoenix App

    This is the main application that retrieves available castles and their associated avatars

    > You will need to run a local instance of Postgres and modify the db config to match your environment.

    ```shell
    cd traceme
    mix do deps.get, ecto.create, ecto.migrate
    mix run priv/repo/seeds.exs
    mix phx.server
    ```

1. Start Avatars Phoenix App

    This app simulate avatar generation.

    ```shell
    cd avatars
    mix do deps.get, phx.server

1. Open Jaeger UI

    Select the TraceMe service and observe the various spans associated with the api calls
    below.

    ```shell
      open http://localhost:16686
    ```

 1. Exercise the tracing APIs

    ```shell
    # Regular call
    curl -XGET http://localhost:4000/api/castles
    # Concurrent Flow call
    curl -XGET http://localhost:4000/api/castles_flow
    # External Avatar Service call
    curl -XGET http://localhost:4000/api/castles_svc
    ```


---
<img src="assets/imhoteplogo.png" width="32" height="auto"/> © 2017 Imhotep Software LLC.
All materials licensed under [Apache v2.0](http://www.apache.org/licenses/LICENSE-2.0)