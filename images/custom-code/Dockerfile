# Official Julia binaries, taken from the official julia image. `julia:1`
# tracks the latest stable 1.x release, so the weekly rebuild picks up new
# Julia versions; pin e.g. julia:1.13 here if you want to hold a version.
FROM julia:1 AS julia

FROM lscr.io/linuxserver/code-server:latest

# Installed system-wide (not under $HOME, which is /config: that path is the
# persistent volume and hides anything the image puts there), so the `abc`
# user code-server runs as can use it.
COPY --from=julia /usr/local/julia /usr/local/julia
RUN ln -s /usr/local/julia/bin/julia /usr/local/bin/julia \
 && julia --version
