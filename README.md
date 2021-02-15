# Raspberry Build

Cross-compiling Rust code for Raspberry Pi Zero W

## Cross-compilation

Target: `arm-unknown-linux-musleabihf`

Requires `arm-linux-gnueabihf-musl-gcc`: https://aur.archlinux.org/packages/arm-linux-gnueabihf-musl/


----

_At the time of creation, https://bugs.archlinux.org/task/69567 was active, so downgrade of binutils to 2.35.1 was necessary:_

```
sudo downgrade binutils
```

_Remember to add `IgnorePkg=binutils` in `/etc/pacman.conf`_

----

## Build for and run on Raspberry

```
./build_push_run.sh
```

You can change variables:

- `TARGET_HOST`
- `TARGET_PATH`
- `TARGET_ARCH`
- `SOURCE_PATH`

Example output

```
> TARGET_HOST=pi@raspberry ./build_push_run.sh
+ : pi@raspberry
+ : /home/pi/raspberry_build
+ : arm-unknown-linux-musleabihf
+ : ./target/arm-unknown-linux-musleabihf/release/raspberry_build
+ cargo build --release --target=arm-unknown-linux-musleabihf
   Compiling raspberry_build v0.1.0 (/home/uname/raspberry_build)
    Finished release [optimized] target(s) in 0.77s
+ scp ./target/arm-unknown-linux-musleabihf/release/raspberry_build pi@raspberry:/home/pi/raspberry_build 
raspberry_build         100% 3642KB 955.9KB/s   00:02    
+ ssh -t pi@raspberry /home/pi/raspberry_build 
Hello, world!
Connection to raspberry closed.
```

## Build, run and test locally

```
cargo b  # build
cargo r  # (build &) run 
cargo t  # test
```

## Useful sources

Sources which helped me to build this repository

[Tiziano Santoro - Compile Rust for Raspberry Pi ARM](https://medium.com/swlh/compiling-rust-for-raspberry-pi-arm-922b55dbb050) - nice idea with deploy script

[Disconnected Systems - Using Rust to Control a Raspberry Pi Zero W Rover](https://disconnected.systems/blog/rust-powered-rover/#using-rust-to-control-a-raspberry-pi-zero-w-rover) - `.cargo/config` setup

[siscia@RedBeardLab - Rust and glibc version](https://redbeardlab.com/2019/05/07/rust-and-glibc-version/) - move from `arm-unknown-linux-gnueabihf` to `arm-unknown-linux-musleabihf`

[FS#69567 - [binutils] missing libctf.so.0](https://bugs.archlinux.org/task/69567)