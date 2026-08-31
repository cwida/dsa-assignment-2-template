# DSA - Assignment 2

Recent work showed that analytical workloads often have repeating queries: on
half of all Amazon Redshift clusters, 80% of queries are repeats of an earlier
one, while TPC-H and TPC-DS contain no repeats at all.[^1] This could be a
dashboard that issues the same or similar queries again, but more recently also
data agents that incrementally explore a dataset.

Currently, DuckDB is not very optimized for these repeated workloads. It is your
job to change that! ⚡

[^1]: Saxena et al., [*Why TPC Is Not Enough: An Analysis of the Amazon Redshift
Fleet*](https://www.vldb.org/pvldb/vol17/p3694-saxena.pdf), PVLDB 17(11), 2024.

## To get started

```sh
git clone --recurse-submodules https://github.com/<you>/<your-repo>.git
cd <your-repo>
```

Then run the setup script, which will allow you to register your team and install the grader's GitHub App:
```shell
python3 ./scripts/assignment-setup.py
```

Without `--recurse-submodules` there is no `duckdb/` to build against.

The setup script takes your team name and student numbers, writes them to
`team.json`, commits it, and opens the grader's GitHub App so you can grant it
access to this repository. **Nothing you push is graded until that App is
installed** - the installations are the roster, there is no separate sign-up.
Re-run it whenever your team changes; previous answers come back as defaults.

Teams are **2 or 3 students**. Your **team name appears on the public
leaderboard**, so pick one you are happy to be seen with, or one that does not
identify you. Student numbers are only ever read by the grader.

> [!IMPORTANT]
> Your repository must stay **private**. A fork of a public template cannot be
> made private, which is why you create your copy with *Use this template →
> Private* rather than by forking.

## Building

```sh
git clone https://github.com/Microsoft/vcpkg.git
./vcpkg/bootstrap-vcpkg.sh
export VCPKG_TOOLCHAIN_PATH=`pwd`/vcpkg/scripts/buildsystems/vcpkg.cmake

make          # -> build/release/duckdb, and the .duckdb_extension that gets graded
make test     # the SQL tests in test/sql
```

`src/waddle_extension.cpp` ships a placeholder scalar function so the template
builds green. Delete it; it is scaffolding, not a starting design.
`docs/README.md` is the upstream extension-template documentation - CLion setup,
debugging, submodules.

# Benchmark

You will be given a stream of SQL queries that are run against the IMDB
database. Your task is to write a DuckDB extension that optimizes the queries.

There is a public and a private query set. The public set is yours to develop
against. The private set uses the same patterns with different instances, and is
what actually ranks you.

Each set is a directory of `.sql` files, **one statement per file**, run in
order through the DuckDB CLI and timed with `EXPLAIN ANALYZE` under:

```sql
SET threads = 4;
SET memory_limit = '4000MB';
SET preserve_insertion_order = false;
LOAD '<your extension>';
```

Every query runs **3 times and the best time counts**. Your score is the
**geometric mean of those per-query best times**, so one lucky run cannot carry
you and one slow query cannot sink you.

> [!WARNING]
> **A fast wrong answer scores nothing.** Every result must match what stock
> DuckDB returns. Some queries in the stream closely resemble others without
> being equivalent to them, and the resemblance is deliberate.

Grading runs nightly on `linux_arm64`: your repository is cloned, built in a
disposable container, checked that the artifact loads and targets the right
platform, then benchmarked. Both the build and the benchmark are sandboxed with
**no network**, a read-only filesystem apart from a scratch directory, 6 GB of
memory and 6 CPUs. The build is killed after 45 minutes, the benchmark after 60.

### What you may and may not change

The grader **repins the `duckdb/` submodule to v1.5.5** before building,
whatever your submodule points at. Develop against that.

| | |
|---|---|
| `src/`, `test/` | yours - this is the assignment |
| `CMakeLists.txt` | fine to edit to add source files; the change is logged |
| `Makefile`, `extension_config.cmake`, `vcpkg.json` | these feed the **DuckDB** build, not just yours. Changes are flagged for review |
| `duckdb/` | do not modify. The assignment is the extension, not the engine |

Renaming the extension away from `waddle` is allowed - the grader reads
`EXT_NAME` from the `Makefile` - but it buys you nothing, so it is easier not to.

## Layout

```
src/                     your extension
test/sql/                SQL tests, run by `make test`
scripts/assignment-setup.py   team registration + App install
docs/                    upstream extension-template docs
duckdb/                  DuckDB submodule, pinned to v1.5.5
extension-ci-tools/      the build machinery
team.json                written by the setup script - do not hand-edit
```

## Getting help

<!-- TODO: schedule, deadlines, and the weekly subtasks -->
<!-- TODO: where to download the public query set -->
<!-- TODO: link to the full assignment description and the leaderboard -->

If the nightly grader rejects your submission it records why, and you will be
told. Most failures are `team.json` or a build that does not reproduce in the
container.
