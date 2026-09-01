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

Press **Use this template → Create a new repository** (top-right of the GitHub page, green button) and set it to **Private**.
Do not fork: a fork of a public repository cannot be made private. Then invite
your team members to it as collaborators.

Clone it with its submodules, or there is no `duckdb/` to build against:

```sh
git clone --recurse-submodules https://github.com/<you>/<your-repo>.git
cd <your-repo>
```

Register your team and install the grader's GitHub App: 
It will give us read access to each repository it is installed for, so only install it for the repo you want to be graded for. 

```sh
python3 ./scripts/assignment-setup.py
```

It writes `team.json`, asks when your CI should build, commits both, and opens the
App so you can grant it access. **Nothing is graded until the App is installed** -
the installations are the roster, there is no separate sign-up.

Teams are **2 or 3 students**. Your **team name appears on the public
leaderboard**; your student numbers never do.

### The IMDB database

The queries in `benchmark/` run against the IMDB (JOB) dataset, which is not in
this repository. Download it once:

```sh
python3 ./scripts/download-imdb.py
```

It fetches the ~1.3 GB dump, loads it into `data/imdb.duckdb` and checks the row
counts. Expect ten minutes or so, 2.5 GB left on disk and about 9 GB needed while
it runs. `data/` is git-ignored - never commit the database.

The load needs a DuckDB CLI at the pinned version. It uses `build/release/duckdb`
or one on your `PATH` if either is v1.5.5, and otherwise downloads the official
binary and throws it away afterwards - so you can do this before your first build.
Re-running the script is a no-op; pass `--force` to rebuild, or `--duckdb PATH` to
choose the CLI yourself.

Then a query is just:

```sh
duckdb data/imdb.duckdb < benchmark/q0000.sql
```

`scripts/imdb_schema.sql` is the schema those queries are written against, and it
is the same schema the grader loads its copy with - primary keys included, so the
ART index on every `id` is there on both sides. **Build your copy with the script
and leave it alone.** Adding an index, or loading the dump some other way, gives
you plans the grader will never produce, and you would be optimizing against a
database that is not the one you are scored on.

## Building

```sh
git clone https://github.com/Microsoft/vcpkg.git
./vcpkg/bootstrap-vcpkg.sh
export VCPKG_TOOLCHAIN_PATH=`pwd`/vcpkg/scripts/buildsystems/vcpkg.cmake

make          # -> build/release/duckdb and build/release/extension/
make test     # the SQL tests in test/sql
```

`docs/README.md` is the upstream extension-template documentation - CLion setup,
debugging, submodules.

# Task 

You will be given a stream of SQL queries that are run against the IMDB
database. Your task is to write a DuckDB extension that optimizes the queries.

There is a public and a private query set. The public set is in `benchmark/` and
is yours to develop against. The private set is held back; it uses the same
patterns with different instances, and is what actually ranks you.

Each set is a directory of `.sql` files, **one statement per file**, named
`q0000.sql` upwards. They are run **in filename order**, `q0000` first - the
order is part of the workload. Each is piped through the DuckDB CLI and
timed with `EXPLAIN ANALYZE` under:

```sql
SET threads = 4;
SET memory_limit = '4000MB';
SET preserve_insertion_order = false;
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

No push builds anything by default: start a build yourself from the Actions tab
(*Run workflow*), or turn on building every push to `main` during setup. A build
costs about 33 of the 2000 free Actions minutes a private repository gets per
month.

### What you may and may not change

**DuckDB is pinned to v1.5.5** by `duckdb_version` in
`.github/workflows/MainDistributionPipeline.yml`, which is what your CI checks the
`duckdb/` submodule out to. An extension only loads into the version it was built
against, so a binary built against anything else cannot be benchmarked at all.

| | |
|---|---|
| `src/`, `test/` | yours - this is the assignment |
| `benchmark/` | yours to run against locally. The grader benchmarks its own copy, so editing these changes nothing |
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
benchmark/               the public query set, run in filename order
data/imdb.duckdb         the dataset, git-ignored, written by the script below
test/sql/                SQL tests, run by `make test`
scripts/assignment-setup.py   team registration + App install
scripts/download-imdb.py      builds data/imdb.duckdb from the CWI dump
scripts/imdb_schema.sql       the IMDB schema the queries are written against
docs/                    upstream extension-template docs
duckdb/                  DuckDB submodule, pinned to v1.5.5
extension-ci-tools/      the build machinery
.github/workflows/       builds the binary that gets graded
team.json                written by the setup script - do not hand-edit
```
