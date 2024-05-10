ExternalProject_Add(ffmpeg
    DEPENDS
        amf-headers
        nvcodec-headers
        bzip2
        lcms2
        openssl
        libsrt
        libass
        libpng
        libvpx
        libzimg
        fontconfig
        harfbuzz
        x264
        ${ffmpeg_x265}
        libvpl
        libopenmpt
        shaderc
        libplacebo
        libzvbi
        rav1e
        uavs3d
        rubberband
        libva
    GIT_REPOSITORY https://github.com/FFmpeg/FFmpeg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests/ref/fate"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 <SOURCE_DIR>/configure
        --cross-prefix=${TARGET_ARCH}-
        --prefix=${MINGW_INSTALL_PREFIX}
        --arch=${TARGET_CPU}
        --target-os=mingw32
        --pkg-config-flags=--static
        --enable-cross-compile
        --enable-runtime-cpudetect
        --enable-gpl
        --enable-version3
        --enable-postproc
        --disable-avisynth
        --disable-vapoursynth
        --enable-libass
        --disable-libbluray
        --disable-libdvdnav
        --disable-libdvdread
        --enable-libfreetype
        --enable-libfribidi
        --enable-libfontconfig
        --enable-libharfbuzz
        --disable-libmodplug
        --enable-libopenmpt
        --disable-libmp3lame
        --enable-lcms2
        --disable-libopus
        --disable-libsoxr
        --disable-libspeex
        --disable-libvorbis
        --disable-libbs2b
        --enable-librubberband
        --enable-libvpx
        --disable-libwebp
        --enable-libx264
        --enable-libx265
        --disable-libaom
        --enable-librav1e
        --disable-libdav1d
        --disable-libdavs2
        --enable-libuavs3d
        --disable-libxvid
        --enable-libzimg
        --enable-openssl
        --disable-libxml2
        --disable-libmysofa
        --disable-libssh
        --enable-libsrt
        --enable-libvpl
        --disable-libjxl
        --enable-libplacebo
        --enable-libshaderc
        --enable-libzvbi
        --disable-libaribcaption
        --enable-cuda-llvm
        --enable-cuvid
        --enable-nvdec
        --enable-nvenc
        --enable-amf
        --disable-openal
        --enable-opengl
        --disable-doc
        --disable-ffplay
        --disable-ffprobe
        --enable-vaapi
        --disable-vdpau
        --disable-videotoolbox
        --disable-decoder=libaom_av1
        ${ffmpeg_lto}
        --extra-cflags='-Wno-error=int-conversion'
        "--extra-libs='${ffmpeg_extra_libs}'" # -lstdc++ / -lc++ needs by libjxl and shaderc
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ffmpeg)
cleanup(ffmpeg install)
