# mold (unofficial)

This is a Docker image that simply contains a prebuilt version of the mold linker.

To use it in your Dockerfile simply copy paste the below lines somewhere. Note that I've built mold using debian:bullseye-slim with dynamic libraries, meaning it has some dependencies, and if you try to use it on a different system it might not work. 

**NOTE!!** According to my tests, the compile time was more or less completely unaffected by using mold. Your project may see larger gains than I did, but for my projects it seems like this was all a huge waste of time and the hour or two I spent making this is time I'll never get back from the compile time gains. I only recommend testing this approach because I've already done the heavy lifting for you, there are potentially bigger time gains to be made in some projects, but for my own purposes this was all a huge waste of time and you might as well just skip it.

I suggest looking into `cargo chef` along with Github Actions buildx image layer caching, that made a much bigger difference than anything else I've tested for speeding up builds.

Currently I've only set it up for use with the `bullseye` version of Debian!

To use it, install the dependencies and copy the mold binary and the Cargo config.

```yaml
RUN apt update && \
    apt install -yq clang libssl-dev
COPY --from=ghcr.io/simonhyll/mold:latest /mold /usr/local/bin/mold
COPY --from=ghcr.io/simonhyll/mold:latest /config.toml /app/.cargo/config.toml
```
