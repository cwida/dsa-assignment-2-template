# DSA - Assignment 2

Recent work showed that analytical workloads often have repeating queries: on
half of all Amazon Redshift clusters, 80% of queries are repeats of an earlier
one, while TPC-H and TPC-DS contain no repeats at all.[^1] This could be a
dashboard that issues the same or similar queries again, but more recently also
data agents that incrementally explore a dataset.

Currently, DuckDB is not very optimized for these repeated workloads. It is your
job to change that by writing a DuckDB extension! ⚡

[^1]: Saxena et al., [*Why TPC Is Not Enough: An Analysis of the Amazon Redshift
Fleet*](https://www.vldb.org/pvldb/vol17/p3694-saxena.pdf), PVLDB 17(11), 2024.

## To get started

Press **Use this template → Create a new repository** and set it to **Private**.
Do not fork: a fork of a public repository cannot be made private. Then invite
your team members to it as collaborators.

Clone it with its submodules, or there is no `duckdb/` to build against:

```sh
git clone --recurse-submodules https://github.com/<you>/<your-repo>.git
cd <your-repo>
```

Register your team and install the grader's GitHub App:

```sh
python3 ./scripts/assignment-setup.py
```

It writes `team.json`, asks when your CI should build, commits both, and opens the
App so you can grant it access. **Nothing is graded until the App is installed** -
the installations are the roster, there is no separate sign-up.

Teams are **2 or 3 students**. Your **team name appears on the public
leaderboard**; your student numbers never do.

## Building

```sh
git clone https://github.com/Microsoft/vcpkg.git
./vcpkg/bootstrap-vcpkg.sh
export VCPKG_TOOLCHAIN_PATH=`pwd`/vcpkg/scripts/buildsystems/vcpkg.cmake

make          # -> build/release/duckdb and build/release/extension/
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
SET temp_directory = '<scratch>';
LOAD '<your extension>';
```

Every query runs **3 times**. Each run scores the **geometric mean** of its query
times and the **fastest run counts**.

> [!WARNING]
> **A fast wrong answer scores nothing.** Every result must match what vanilla
> DuckDB returns. 

Grading runs nightly, but **your CI is responsible for building.** The grader
benchmarks the binary from your last successful build, so the commit it grades is
the newest one you have *built* - not necessarily your latest commit. The
leaderboard shows which one it used.

Pushing to `main` builds automatically unless you turned
that off during setup. A build costs about 33 of the 2000 free Actions minutes a
private repository gets per month.

### What you may and may not change

**DuckDB is pinned to v1.5.5** by `duckdb_version` in
`.github/workflows/MainDistributionPipeline.yml`, which is what your CI checks the
`duckdb/` submodule out to. An extension only loads into the version it was built
against, so a binary built against anything else cannot be benchmarked at all.

| | |
|---|---|
| `src/`, `test/` | yours - this is the assignment |
| `CMakeLists.txt` | fine to edit to add source files; the change is logged |
| `Makefile`, `extension_config.cmake`, `vcpkg.json` | these feed the **DuckDB** build, not just yours. Changes are flagged for review |
| `.github/workflows/` | how your binary comes to exist. Changing `duckdb_version` or `uses` is flagged, and breaks your submission |
| `duckdb/` | changing it gains you nothing: your extension is benchmarked inside a DuckDB the grader built at the pinned commit, never one from your tree |

Renaming the extension away from `waddle` is allowed - change both `EXT_NAME` in
the `Makefile` and `extension_name` in the workflow - but editing the `Makefile`
is flagged for review, and it buys you nothing.

## Layout

```
src/                     your extension
test/sql/                SQL tests, run by `make test`
scripts/assignment-setup.py   team registration + App install
docs/                    upstream extension-template docs
duckdb/                  DuckDB submodule, pinned to v1.5.5
extension-ci-tools/      the build machinery
.github/workflows/       builds the binary that gets graded
team.json                written by the setup script - do not hand-edit
```
