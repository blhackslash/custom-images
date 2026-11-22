FROM nextcloud:35

# ffmpeg for video previews. --no-install-recommends skips the VA-API/VDPAU
# GPU driver stacks that Debian pulls in as "recommended"; Nextcloud's
# preview generator uses plain CPU ffmpeg and doesn't need them.
RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg \
 && rm -rf /var/lib/apt/lists/* \
 && ffmpeg -hide_banner -version | head -n1
