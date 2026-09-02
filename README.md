# DSA - Assignment 2

Recent work showed that analytical workloads often have repeating queries: on
half of all Amazon Redshift clusters, 80% of queries are repeats of an earlier
one, while standard benchmarks like TPC-H and TPC-DS contain no repeats at all.[^1] 
Repeating queries could come from for example from a dashboard that issues the same or similar queries again, or more recently also
data agents that incrementally explore a dataset.

Currently, DuckDB is not very optimized for these repeated workloads. It is your
job to change that by writing a DuckDB extension! ⚡

[^1]: Saxena et al., [*Why TPC Is Not Enough: An Analysis of the Amazon Redshift
Fleet*](https://www.vldb.org/pvldb/vol17/p3694-saxena.pdf), PVLDB 17(11), 2024.

## Getting started

Press **Use this template → Create a new repository** (top-right of the GitHub page, green button) and set it to **Private**.
Do not fork: a fork of a public repository cannot be made private. Then invite
your team members to it as collaborators.

Clone your repo with its submodules, otherwise it will be missing duckdb and can't test your extension.

```sh
git clone --recurse-submodules https://github.com/<you>/<your-repo>.git
cd <your-repo>
```

*Register your team and install the grader's GitHub App:* 
It will give us read access to each repository it is installed for, so only install it for the repo you want to be graded for. 

```sh
python3 ./scripts/assignment-setup.py
```

The script writes `team.json`, asks when your CI should build, commits both, and
opens the grader's GitHub App to install. The App reads every repository it is
installed for, so install it only for your assignment repository. 
**We can't evaluate your submission without the App** - there is no separate sign-up.

# Task 

You will be given a stream of SQL queries that are run against the IMDB
database. Your task is to write a DuckDB extension that optimizes the queries.

There is a public and a private query set. The public set is in `benchmark/` of this template and
is yours to develop against. The private set is ... private, and will be used for the leaderboard; it uses the similar query
patterns, and is what actually ranks you.

Each set is a directory of `.sql` files, **one statement per file**, named
`q0000.sql` upwards. They are run **in filename order**, `q0000` first - the
order is part of the workload. 

When running the benchmark for the leaderboard, we will use the following settings:
```sql
SET threads = 6;
SET memory_limit = '8000MB';
SET preserve_insertion_order = false;
```

The set runs **twice**. A run scores the **geometric mean** of its query times,
and the **faster run counts**.

> [!WARNING]
> **A fast wrong answer scores nothing.** Every result must match what vanilla
> DuckDB returns.

Grading runs nightly, but **your CI is responsible for building.** The grader
benchmarks the binary from your last successful CI build, so the commit it grades is
the newest one you have *built* - not necessarily your latest commit. The
leaderboard shows which one it used.

No push builds anything by default: start a build yourself from the Actions tab
(*Run workflow*), or turn on building every push to `main` during setup. A build
costs about 33 of the 2000 free Actions minutes a private repository gets per
month, so if you want to build every push, make sure your team has enough minutes.

### Download Datasets

The queries in `benchmark/` run against the IMDB (JOB) dataset, which is not in
this repository. Download it once:

```sh
python3 ./scripts/download-imdb.py
duckdb data/imdb.duckdb < benchmark/q0000.sql
```

`scripts/imdb_schema.sql` is the schema those queries are written against. It
is the same schema that will be used for the leaderboard.

### Building

```sh
make          # -> build/release/duckdb and build/release/extension/
make test     # the SQL tests in test/sql
```

`docs/README.md` is the upstream extension-template documentation - CLion setup,
debugging, submodules.


### What you may and may not change

**We will use DuckDB v1.5.5 to benchmark your extension, so you must build against that version.**

DuckDB is pinned to v1.5.5 by `duckdb_version` in
`.github/workflows/MainDistributionPipeline.yml`, which is what your CI checks the
`duckdb/` submodule out to. An extension only loads into the version it was built
against, so a binary built against anything else cannot be benchmarked at all.

Please don't rename your extension, as this will (potentially) break the grader.

| File or directory  | What you can do |
|---|---|
| `src/`, `test/` | yours - this is the assignment |
| `benchmark/` | yours to run against locally. The grader benchmarks its own copy, so editing these changes nothing |
| `CMakeLists.txt` | fine to edit to add source files; the change is logged |
| `Makefile`, `extension_config.cmake`, `vcpkg.json` | these feed the **DuckDB** build, not just yours. Changes are flagged for review |
| `.github/workflows/` | how your binary comes to exist. Changing `duckdb_version` or `uses` is flagged, and breaks your submission |
| `duckdb/` | changing it gains you nothing: your extension is benchmarked inside a DuckDB the grader built at the pinned commit, never one from your tree |
