# thesis-measurements

Scripts and models for the measurements in the bachelor's thesis *Where the
Memory Goes: Design and Evaluation of a Synchronous Rust HTTP Client for Process
Instances on Edge Devices*. The client itself is at
<https://github.com/CarloTUM/Bachelor-Thesis>.

Everything runs on an Orange Pi Zero 2W (aarch64, Armbian on Debian trixie).
Binaries are cross compiled with `cross` on a workstation, nothing is built on
the device.

## Contents

`build_scripts/`, one per configuration: CF1 baseline reqwest, CF2 curl rustls,
CF3 OpenSSL static, CF4 OpenSSL dynamic, CF5 wolfSSL dynamic, CF6 wolfSSL
static. `build_wolfssl_libs.sh` builds the minimal libcurl that CF5 and CF6 use,
`probe_os.sh` rebuilds it at `-Os` (the size bound in the threats to validity).

`models/`, the four pattern models and `bench_highload_cell` for the scaling and
throughput runs.

`profiling/`: `run_time.sh` (one instance under `time -v`), `run_heaptrack.sh`,
`psample.sh` (smaps_rollup of all instances every 0.25 s), `sample1hz.sh` (the
same at 1 Hz), `scale_run.sh` (1, 5, 10, 25, 50 instances, 200 s per level).
`heaptrack/` holds the two traces of the Sequence pattern and the interactive
flame graphs from the appendix.

`results/fault-around/`, the `time -v` output of the control runs with
`fault_around_bytes` at 65536 and at 4096.

## Deploying

Start the instances with `behavior=fork_ready`, fetch `instance.rs` from
`/properties/dsl/`, build with the script of the configuration. Layout on the
device:

```
bench/<config>/<model>/shared/   weel_bin, libweel_lib.so, libstd-*.so
bench/<config>/<model>/<id>/     opts.json, context.json
```

rsync that to the device and copy `profiling/*.sh` into `bench/`. Then run
`run_time.sh` or `run_heaptrack.sh` from an instance directory, or
`./scale_run.sh <config> bench_highload_cell` from `bench/`. The samplers take
the output CSV as argument and run in the background next to a measurement.

`LD_LIBRARY_PATH` and `SSL_CERT_FILE` are set by the scripts. `heaptrack` has to
be installed on the device.
