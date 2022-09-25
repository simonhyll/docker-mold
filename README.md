# mold (unofficial)

This is a Docker image that simply contains a prebuilt version of the mold linker.

To use it in your Dockerfile simply copy paste the below lines somewhere. Note that I've built mold using debian:bullseye-slim with dynamic libraries, meaning it has some dependencies, and if you try to use it on a different system it might not work. Also, according to my tests, the compile time gain was just a second or two. Your project may see larger gains but for my projects it seems like this was all a huge waste of time and the hour or two I spent making this is time I'll never get back from the compile time gains. I only recommend testing this approach because I've already done the heavy lifting for you, there are potentially bigger time gains to be made in some projects, but for my own purposes this was all a huge waste of time and you might as well just skip it.

Currently I've only set it up for use with the `bookworm` version of Debian!

To use it, install the dependencies and copy the mold binary and the Cargo config.

```yaml
RUN apt update && \
    apt install -yq clang libssl-dev
COPY --from=mold-test /mold /usr/local/bin/mold
COPY --from=mold-test /config.toml /app/.cargo/config.toml
```
