# README - PostGIS Exposure Tool

> **Note:** This toolkit does **not** require or share any Protected Health Information (PHI).

Spatially joins the latitude and longitude in your OMOP `LOCATION` / `LOCATION_HISTORY` tables against environmental and social determinant datasets (ADI, SVI, EJI, AHRQ), and produces an OMOP `EXTERNAL_EXPOSURE` table.

```
Your data  →  Step 2: geocoding  →  LOCATION.csv          →  Step 4: linkage  →  EXTERNAL_EXPOSURE.csv
                                    LOCATION_HISTORY.csv       (this container)
```

**This container performs Step 4.** Steps 1–3 produce the `LOCATION` tables it consumes and are handled by the [Exposome Geocoder](https://github.com/bihorac-LAB/EnvironmentalData); they are summarised here and covered in full in its [User Manual](https://github.com/bihorac-LAB/EnvironmentalData/blob/main/Tools/doc/UserManual.md).

---

## 📑 Table of Contents

- [Overview](#overview)
- [Input Options](#input-options)
- [Usage Guide](#usage-guide)
  - [Step 1: Prepare Input Data](#step-1-prepare-input-data)
  - [Step 2: Generate LOCATION Tables](#step-2-generate-location-tables)
  - [Step 3: What Linkage Expects](#step-3-what-linkage-expects)
  - [Step 4: GIS Linkage](#step-4-gis-linkage)
    - [Datasets Linked](#datasets-linked)
    - [Prerequisites](#prerequisites)
    - [Linkage Workflow](#linkage-workflow)
    - [Notes \& Tips](#notes--tips)
  - [Step 5: Validate \& Inspect Outputs](#step-5-validate--inspect-outputs)
  - [Step 6: Site-level Date Shifting (Optional)](#step-6-site-level-date-shifting-optional)
  - [Step 7: Upload \& Centralized De-identification](#step-7-upload--centralized-de-identification)
- [References \& Sample Files](#references--sample-files)
- [Related Office Hours](#related-office-hours)

---

## Overview

The end-to-end workflow uses **two Docker containers**:

1. **Exposome Geocoder (`prismaplab/exposome-geocoder:1.0.4`)**  
   Converts addresses or coordinates into OMOP `LOCATION` / `LOCATION_HISTORY` tables with latitude and longitude.

2. **Exposome Linkage — this container (`ghcr.io/chorus-ai/chorus-postgis-exposure:main`)**  
   Spatially joins those tables with the SDoH datasets to produce `EXTERNAL_EXPOSURE.csv`.

Linkage joins on **latitude and longitude**. The path is the same for every site.

---

## Input Options

Prepare **only ONE** of the following per encounter, then run [Step 2](#step-2-generate-location-tables) to turn it into `LOCATION` tables.

| Option | You supply | Sample files |
|--------|------------|--------------|
| **1. Address** | Either multi-column (`street`, `city`, `state`, `zip`) or a single `address` column, plus `location_id`, `year`, `entity_id` | [address_files/input](https://github.com/bihorac-LAB/EnvironmentalData/tree/main/Tools/demo/address_files/input) |
| **2. Coordinates** | `latitude`, `longitude`, plus `location_id`, `year`, `entity_id` | [latlong_files/input](https://github.com/bihorac-LAB/EnvironmentalData/tree/main/Tools/demo/latlong_files/input) |
| **3. OMOP CDM** | Export `person`, `visit_occurrence`, `location`, `location_history`, then run Step 2 on the CSVs | [OMOP/output](https://github.com/bihorac-LAB/EnvironmentalData/tree/main/Tools/demo/OMOP/output) |

> ⚠️ **Required for every row:** a non-blank `location_id` (these are **not** auto-generated, so supply your own site-stable identifiers), and **either** an address **or** a ZIP code.

If you already have CDM-format `LOCATION.csv` / `LOCATION_HISTORY.csv`, supply them as input and the geocoder will fill in the coordinates. Otherwise it builds both files for you.

See the [User Manual](https://github.com/bihorac-LAB/EnvironmentalData/blob/main/Tools/doc/UserManual.md#input-options) for the full column-level formats.

---

## Usage Guide

### Step 1: Prepare Input Data

Place your CSV file(s) in a dedicated folder — for example 📂 `input_address/` or 📂 `input_coordinates/`. Optionally include `LOCATION.csv` and `LOCATION_HISTORY.csv`.

> ⚠️ Only `.csv` files are supported. Convert `.xlsx` or other formats first.
>
> ⚠️ **Do not date-shift** your `LOCATION` / `LOCATION_HISTORY` files before linkage — the join needs true dates to select the correct dataset vintage. Shift after linkage, in [Step 6](#step-6-site-level-date-shifting-optional).

---

### Step 2: Generate LOCATION Tables

**Container:** `prismaplab/exposome-geocoder:1.0.4` (Docker Desktop must be running.)

```bash
docker run -it --rm \
  -v "$(pwd)":/workspace \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e HOST_PWD="$(pwd)" \
  -w /workspace \
  prismaplab/exposome-geocoder:1.0.4 \
  /app/code/Address_to_LOCATION.py -i <input_folder_path>
```

On Windows, run this inside WSL. Outputs land in an `output/` folder alongside your input:

```
output/
├── LOCATION.csv                        # OMOP CDM LOCATION + modifier_source_value
├── LOCATION_HISTORY.csv                # OMOP CDM LOCATION_HISTORY
├── geocoding_summary_<timestamp>.csv   # rows resolved per fallback tier
└── geocode_failures_<timestamp>.csv    # rows that could not be geocoded
```

Coordinates are resolved through a four-tier fallback (lat/long supplied → street address → ZIP9 centroid → ZIP5 centroid), and the tier used for each row is recorded in `modifier_source_value`.

> ⚠️ **Version note:** Use **`1.0.4` or later**. `Address_to_LOCATION.py` and the ZIP9/HUD crosswalk data it depends on are **not present in `1.0.3` or earlier**.

> ℹ️ All geocoding runs **locally**; no address data leaves your machine. For the fallback thresholds, environment variables, failure reasons and DeGAUSS internals, see [Appendix A of the User Manual](https://github.com/bihorac-LAB/EnvironmentalData/blob/main/Tools/doc/UserManual.md#appendix-a-geocoding-workflow).

---

### Step 3: What Linkage Expects

Whatever produced your tables, this is the contract this container validates against. **Any column outside these sets fails validation.**

**LOCATION.csv**

| Column | |
|--------|--|
| `location_id`, `latitude`, `longitude` | **Required.** The run fails if any are missing. |
| `address_1`, `address_2`, `city`, `state`, `zip`, `county`, `location_source_value`, `country_concept_id`, `country_source_value` | Optional, standard OMOP CDM `LOCATION` columns. |
| `modifier_source_value` | Optional 13th column recording geocoding provenance. The `location_raw` table declares it explicitly, so **do not strip it** if your geocoder emits it. |

**LOCATION_HISTORY.csv**

| Column | |
|--------|--|
| `location_id`, `start_date` | **Required.** |
| `relationship_type_concept_id`, `domain_id`, `entity_id`, `end_date` | Optional. |

> **Blank values are meaningful.** `entity_id`, `start_date` and `end_date` are left blank when the source data does not supply them rather than filled with placeholders. Review these before linkage.

---

### Step 4: GIS Linkage

Spatially joins the latitude and longitude from your `LOCATION` tables with the geospatial indices and produces `EXTERNAL_EXPOSURE.csv`.

#### Datasets Linked

All are joined at **Census tract** level, using Census TIGER/Line tract geometry (data source `7700`) as the spatial backbone.

| Dataset | Source | Vintages available | Variables |
|---------|--------|--------------------|-----------|
| **ADI** — Area Deprivation Index | UW-Madison (Zenodo) | 2015, 2020, 2023 | 6 |
| **SVI** — Social Vulnerability Index | CDC/ATSDR | 2010, 2014, 2016, 2018, 2020, 2022 | 651 |
| **EJI** — Environmental Justice Index | CDC/ATSDR | 2022, 2024 | 239 |
| **AHRQ SDOH** — Social Determinants of Health | AHRQ (Zenodo) | 2009–2023, annual | 4,195 |

**How the ID numbers map.** The two CSVs in [`csv/`](./csv) are the lookup tables for the numbers you pass below. They are centrally managed; no edits required.

| File | Column to use | Maps to |
|------|---------------|---------|
| [`csv/VRBL_SRC_SIMPLE.csv`](./csv/VRBL_SRC_SIMPLE.csv) | `variable_source_id` → `VARIABLES` | One row per variable. `variable_name` is what lands in `exposure_source_value`; `dataset_type` says which family it belongs to. |
| [`csv/DATA_SRC_SIMPLE.csv`](./csv/DATA_SRC_SIMPLE.csv) | `data_source_uuid` → `DATA_SOURCES` | One row per dataset **vintage** (dataset + year), with download and documentation URLs. |

To check what an ID is before requesting it, look the number up in the relevant file — `data_source_uuid` `9922`, for example, is SVI's 2022 tract release.

#### Prerequisites

- Docker installed.
- This repository cloned; run all commands **from the `postgis-exposure` directory**.
- `LOCATION.csv` and `LOCATION_HISTORY.csv` from [Step 2](#step-2-generate-location-tables).

#### Linkage Workflow

**Step 0: Stage your input files.** Copy both CSVs into the `test/` directory. The container reads them from the mount; there is **no separate ingest command**.

```bash
cp /path/to/output/LOCATION.csv         ./test/
cp /path/to/output/LOCATION_HISTORY.csv ./test/
```

**Step 1: Set the variable and data-source lists.**

```bash
export VARIABLES="96,98,100,102,110,112,116,118,120,122,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,156,157,159,197,199,201,203,211,213,217,254,256,258,260,268,270,274,276,278,280,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,314,315,317,319,334,360,362,364,366,374,378,380,382,384,386,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,422,423,470,496,498,500,502,510,514,516,518,520,522,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541,558,559,592,593,594,595,601,603,611,612,613,614,615,616,617,618,622,623,632,633,674,675,676,677,678,681,685,687,689,691,692,693,694,695,696,717,718,719,720,721,722,723,724,729,730,739,740,831,832,833,834,835,836,1795,1796,1797,1798,1799,1800,1801,1802,1803,1804,1805,1806,1807,1808,1809,1810,1811,1812,1813,1814,1815,1816,1817,1818,1819,1820,1821,1822,1823,1824,1825,1826,1827,1828,1829,1830,1831,1832,1833,1834,1835,1836,1837,1838,1839,1840,1841,1842,1843,1844,1845,1846,1847,1848,1849,1850,1851,1852,1853,1854,2322,2323,2324,2325,2326,2327,2328,2329,2330,2331,2332,2333,2334,2335,2336,2421,2422,2423,2424,2425,2426,2427,2428,2429,2430,2431,2432,2433,2434,2435,2436,2437,2438,2439,2440,2441,2442,2443,2444,2445,2446,2447,2448,2449,2583,2584,2585,2586,2587,2588,2589,2590,2591,2592,2593,2594,2595,2596,2597,3214,3215,3216,3217,3218,3219,3220,3221,3222,3223,3224,3225,3226,3227,3228,3229,3230,3231,3232,3233,3234,3235,3831,3832,3833,3834,3835,3836,3837,3838,3839,3840,3841,3842,3843,3844,3845,3846,3847,3848,3849,3850,3851,3852,3853,3854,3855,3856,3857,3858,3859,4179,4180,4181,4182,4183,4184,4185,4186,4187,4188,4189,4190,4191,4192,4221,4222,4223,4224,4225,4226,4227,4228,4229,4230,4231,4232,4233,4234,4235,4236,4237,4238,4239,4240,4241,4242,4243,4244,4245,4246,4247,4248,4249,4315,4316,4317,4318,4319,4320,4321,4322,4323,4324,4325,4326,4327,4328,4329,4352,4353,4354,4355,4356,4357,4358,4359,4360,4361,4362,4363,4364,4365,4366,4367,4368,4369,4370,4371,4372,4373,4374,4375,4376,4377,4378,4379,4380,4381,4382,4383,4384,4385,4386,4387,4388,4957,4958,4959,4960,4961,4962,4963,4964,4965,4966,4967,4968,4969,4970,4971,5032,5033,5034,5035,5036,5037,5038,5039,5040,5041,5042,5043,5044,5045,5046,5047,5048,5049,5050,5051,5052,5053,5054,5055,5056,5057,5058,5059,5060,5061,5062,5063,5064,5065,5066,5067,5068,5069,5070,5071,5072,5073,5074,5075,5076,5077,5078,5079,5080,5081,5082,5083,5084,5085,5086,5087,5088,5089,5090,5091"
export DATA_SOURCES="7700,9910,9914,9916,9918,9920,9922,8822,8824,10515,10520,10523,11209,11210,11211,11212,11213,11214,11215,11216,11217,11218,11219,11220,11221,11222,11223"
```

> These are the full canonical lists, generated from [`csv/VRBL_SRC_SIMPLE.csv`](./csv/VRBL_SRC_SIMPLE.csv) and [`csv/DATA_SRC_SIMPLE.csv`](./csv/DATA_SRC_SIMPLE.csv). Those files are authoritative: if they change, regenerate these lists from them. If your site needs a different subset, edit the lists accordingly.

**Step 2: Start the Postgres/PostGIS container.**

```bash
docker run --rm --name postgis-chorus \
    --env POSTGRES_PASSWORD="dummy" \
    --env VARIABLES="$VARIABLES" \
    --env DATA_SOURCES="$DATA_SOURCES" \
    -v ./test:/source \
    -d ghcr.io/chorus-ai/chorus-postgis-exposure:main
```

This brings up a Docker container locally with all dependencies needed to run the dataset retrieval and spatial joining processes.

> `POSTGRES_PASSWORD=dummy` is safe as-is: the database is local to this throwaway container and is never exposed off-host.

> **Alternative: build the image locally.** If your site cannot pull from `ghcr.io`, or you want to run modified code, build from this repo instead. Reuse the same exports from Step 1.
>
> ```bash
> docker build -t chorus-postgis-exposure-local .
>
> docker run --rm --name postgis-chorus \
>     --env POSTGRES_PASSWORD="dummy" \
>     --env VARIABLES="$VARIABLES" \
>     --env DATA_SOURCES="$DATA_SOURCES" \
>     -v ./test:/source \
>     -d chorus-postgis-exposure-local:latest
> ```
>
> Every later step is identical.

**Step 3: Wait for the database to come up** (10-20 seconds depending on your environment). Confirm with:

```bash
docker logs postgis-chorus
```

Wait until you see **`database is ready to accept connections`** before continuing.

**Step 4: Generate the external exposure file.**

```bash
docker exec postgis-chorus /app/produce_external_exposure.sh
```

This retrieves the data sources and combines them with your data to produce the external exposure table.

**Step 5: Collect the output.** `EXTERNAL_EXPOSURE.csv` will appear in your mounted `./test` directory.

**Step 6: Stop the container.**

```bash
docker stop postgis-chorus
```

#### Notes & Tips

- Run these commands in Terminal (Mac) or WSL/PowerShell/Command Prompt on Windows; WSL is more robust for Docker on Windows.
- Run all commands from the `postgis-exposure` directory; the `-v ./test:/source` mount is relative to it.
- **Important:** The container may only run successfully once. To rerun, you may need to delete the container and image, then pull the image again.

---

### Step 5: Validate & Inspect Outputs

`EXTERNAL_EXPOSURE.csv` is in **long format** (one row per location, person, variable and year), not one row per patient. Sample output: [demo/PostGIS-output](https://github.com/bihorac-LAB/EnvironmentalData/tree/main/Tools/demo/PostGIS-output).

| Column | What to check |
|--------|---------------|
| `location_id` | Matches the IDs you supplied in `LOCATION.csv` |
| `person_id` | Populated and matches your source data |
| `exposure_source_value` | Holds the variable name (for example `SVI_EP_POV`, `SVI_EP_UNEMP`) |
| `value_as_number` | Holds the measured value; should not be uniformly blank |
| `exposure_start_date` / `exposure_end_date` | Cover the expected period for each row |
| `sdoh_data_year` | The dataset vintage actually matched |
| `sdoh_year_map_status` | `nearest_year` means the exact year was unavailable and the closest was substituted; expected, but worth knowing |

> ℹ️ **There is no latitude or longitude column in this file.** Coordinates are consumed during the spatial join and are not carried through to the output. Their absence is not an error.

- Spot-check a few records for accuracy.
- Confirm the set of distinct `exposure_source_value` entries matches the `VARIABLES` you requested.
- If errors:
  - Ensure `LOCATION.csv` has valid, non-blank latitude and longitude
  - Confirm `VARIABLES` and `DATA_SOURCES` are correct
  - Check mount paths, and that both CSVs were staged in `./test` before the container started

---

### Step 6: Site-level Date Shifting (Optional)

**Purpose:** Anonymize temporal data while preserving relative timelines.

- Apply date shifts locally before upload; **do not** date-shift prior to GIS linkage.
- Input: `EXTERNAL_EXPOSURE.csv` (from Step 4) → Output: `EXTERNAL_EXPOSURE_date_shifted.csv`

See the [Date Shifting SOP](https://github.com/chorus-ai/Chorus_SOP/blob/main/sop-website/docs/Privacy/Date-Shifting.mdx) for details.

---

### Step 7: Upload & Centralized De-identification

1. Upload the (optionally date-shifted) `EXTERNAL_EXPOSURE.csv` to the central repository.
2. The central team will apply further de-identification.

---

## References & Sample Files

- **Geocoder source repository:** [bihorac-LAB/EnvironmentalData](https://github.com/bihorac-LAB/EnvironmentalData) — produces the `LOCATION` / `LOCATION_HISTORY` inputs.
- **Full workflow documentation:** [Exposome Geocoder User Manual](https://github.com/bihorac-LAB/EnvironmentalData/blob/main/Tools/doc/UserManual.md) — column-level input formats, geocoding internals and troubleshooting.
- **Sample geocoding files:** [Tools/demo](https://github.com/bihorac-LAB/EnvironmentalData/tree/main/Tools/demo)
- **Sample linkage output:** [demo/PostGIS-output](https://github.com/bihorac-LAB/EnvironmentalData/tree/main/Tools/demo/PostGIS-output)
- **Dataset lookup tables:** [`csv/`](./csv) — `DATA_SRC_SIMPLE.csv`, `VRBL_SRC_SIMPLE.csv` (centrally managed)

---

## Related Office Hours

- **[08-07-25] Integration of GIS and SDoH data with OMOP**
  - [Video Recording](https://drive.google.com/file/d/1MHx7YWlWIVC2Dggjzw2uczT3MKyppWZ5/view?usp=share_link) | [Transcript](https://docs.google.com/document/d/1v0C3COo1O-KOKpd7haVm5GGmD5gbVR0I/edit?usp=sharing&ouid=104468275537210259794&rtpof=true&sd=true)
- **[09-18-25] Processing OMOP location_history table into external_exposure table**
  - [Video Recording](https://drive.google.com/file/d/1SWovm3vnf0PVbTC_qS6n3nBuf1dI169L/view?usp=share_link) | [Transcript](https://docs.google.com/document/d/1VII2X_NQhM69ZzUDwB6m4hsqDk6E1VCx/edit?usp=share_link&ouid=104468275537210259794&rtpof=true&sd=true)
- **[09-25-25] End-to-end demo for capturing GIS data with OMOP**
  - [Video Recording](https://drive.google.com/file/d/118fGVQS0ES0SV4Yu6pxLc4SB0Z08Mq9I/view?usp=share_link) | [Transcript](https://docs.google.com/document/d/1-rPcdQp-7TcEF9-Fgwqi12508Mx2seT9/edit?usp=share_link&ouid=104468275537210259794&rtpof=true&sd=true)
- **[10-16-25] End-to-end demo for capturing GIS data with OMOP or address/latlong**
  - [Video Recording](https://drive.google.com/file/d/1L5OdVWa0AsuLKy-o0Uub8JNb1Wojw7ZO/view?usp=drive_link) | [Transcript](https://drive.google.com/file/d/1-P6edkHBfiAJKSG7ZKlkIj5Ej-u2EZ3G/view?usp=sharing)
