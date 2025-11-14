# 🎃 Horrorland dbt Homework - Week 1

[![Powered by DataGym.io](https://img.shields.io/badge/Powered%20by-DataGym.io-%23005FFF?style=for-the-badge\&logo=data\&logoColor=white)](https://www.datagym.io)

**Related repos:**
- **Template**: https://github.com/DataGym-io/2025-08-dbt-mini-bootcamp
- **Complete Code**: https://github.com/DataGym-io/2025-08-dbt-mini-bootcamp-complete
- **Airflow Integration**: https://github.com/DataGym-io/2025-08-dbt-mini-bootcamp-airflow

> 🚨 **IMPORTANT NOTICE – HOMEWORK ASSIGNMENT**
> This is the **Week 1 Homework** for the DataGym.io dbt mini bootcamp.
>
> ✅ **Before starting:**
> 1. Make sure you have completed the setup from the main bootcamp repository
> 2. The project is already initialized, so you don't need to run `dbtf init`
> 3. Use the same `profiles.yml` from your previous setup
>    - If it's in `~/.dbt/profiles.yml` (Mac/Linux) or equivalent Windows location, you're good to go
>    - If it was in the project folder, copy it to the `/horrorland` directory

---

## 📚 Table of Contents

* [👻 Context](#-context)
* [🎯 What You'll Build](#-what-youll-build)
* [📋 Tasks](#-tasks)
* [📤 Submission](#-submission)

---

## 👻 Context

You work at **Horrorland**, a spooky and thrilling theme park, as an **Analytics Engineer**.

Your mission is to transform raw data into well-structured facts and dimensions for the analytics team. This week, you'll focus on **merchandise sales** and **haunted houses** data.

The Halloween season is near, and the business needs insights on:
- Product performance and sales trends
- Haunted house operations and customer experience
- Revenue analysis across different sales channels

---

## 🎯 What You'll Build

In this homework, you'll create:

1. **Sources** - Define data sources for merchandise and haunted house data
2. **Staging Models** - Clean and standardize raw data
3. **Snapshots** - Track changes in product data over time
4. **Dimension Tables** - `dim_products` and `dim_haunted_houses`
5. **Fact Table** - `fct_all_merchandise_sales`
6. **Documentation** - Add descriptions and tests to your models

---

## 📋 Tasks

### 2.1 Define Sources

#### In `horrorland/models/staging/park_assets/_sources.yml`:
Add these sources:
- `MARKETING_HAUNTED_HOUSES`
- `MERCHANDISE_PRODUCTS`
- `OPS_HAUNTED_HOUSES`

#### In `horrorland/models/staging/sales/_sources.yml`:
Add these sources:
- `MERCHANDISE_SALES_ONLINE`
- `MERCHANDISE_SALES_PHYSICAL`

**Add freshness checks for merchandise sales sources:**
- `warn_after: 6 hours`
- `error_after: 18 hours`

### 2.2 Create Staging Models

Create a staging model for each source in their respective folders:
- `stg_park_assets__marketing_haunted_houses.sql`
- `stg_park_assets__merchandise_products.sql`
- `stg_park_assets__ops_haunted_houses.sql`
- `stg_sales__merchandise_sales_online.sql`
- `stg_sales__merchandise_sales_physical.sql`

Important: Merchandise sales price fields arrive in cents. In `stg_sales__merchandise_sales_online.sql` and `stg_sales__merchandise_sales_physical.sql`, use the existing `cents_to_dollars` macro to convert price fields to dollars, while keeping the same column names for correction purposes (e.g., convert `unit_price` and `total_price` from cents to dollars but output columns remain `unit_price` and `total_price`). Do not introduce new columns for converted values.

### 2.3 Create Snapshot

Create a snapshot in `/snapshots` called `snp_merchandise_products.yml` to track changes in the merchandise products source.

**Use the timestamp strategy** for this snapshot to track changes based on the `updated_at` field.

The staging model `stg_park_assets__merchandise_products.sql` should select from this snapshot.


### 2.4 Build Marts

#### Dimension Tables (in `models/marts/master_data/`):

**`dim_products.sql`** - Product information and attributes

**Required columns from staging:**
- `product_id` (Primary key)
- `product_name`, `description`, `category`
- `base_price`, `cost_price`, `profit_margin_percent`
- `current_inventory`, `base_inventory_level`, `reorder_point`
- `material`, `size_options`, `colors`, `supplier`
- `launch_date`, `is_active`, `seasonal`, `limited_edition`
- `created_at`, `updated_at`

**Calculated columns to add:**
- `price_tier`: Categorize products as 'Premium' (≥$50), 'Mid-Range' (≥$25), 'Standard' (≥$10), or 'Budget' (<$10) based on `base_price`
- `margin_category`: Categorize as 'High Margin' (≥80%), 'Medium Margin' (≥60%), 'Low Margin' (≥40%), or 'Minimal Margin' (<40%) based on `profit_margin_percent`
- `product_age`: Categorize as 'New' (launched within 1 year), 'Recent' (within 3 years), 'Established' (within 5 years), or 'Classic' (older than 5 years) based on `launch_date`

**`dim_haunted_houses.sql`** - Haunted house details and characteristics

Combine data from `stg_park_assets__marketing_haunted_houses` and `stg_park_assets__ops_haunted_houses` by joining on `haunted_house_id` (consider a full outer join to preserve rows present in only one source).

**Required columns from staging:**
- `haunted_house_id` (Primary key)
- Marketing fields: `marketing_name`, `description`, `marketing_tagline`, `difficulty_level`, `recommended_for`, `is_featured`, `is_active`, `image_url`
- Operations fields: `house_name`, `fear_level`, `emergency_exits`, `staff_required`, `house_size_sqft`, `park_area`, `min_age_requirement`, `opening_year`, `safety_rating`, `max_daily_capacity`, `theme`, `accessibility_friendly`, `max_capacity_per_group`, `house_status`, `duration_minutes`
- Timestamps: `marketing_created_at`, `marketing_updated_at`, `ops_created_at`, `ops_updated_at`

**Calculated columns to add:**
- `size_category`: Categorize as 'Large' (≥10,000 sqft), 'Medium' (≥5,000 sqft), or 'Small' (<5,000 sqft) based on `house_size_sqft`
- `age_category`: Categorize as 'New' (opened ≥2020), 'Recent' (≥2010), 'Established' (≥2000), or 'Classic' (<2000) based on `opening_year`

#### Fact Table (in `models/marts/finance/`):

**`fct_all_merchandise_sales.sql`** - Sales transactions combining online and physical sales

Build this table by UNION ALL of `stg_sales__merchandise_sales_online` and `stg_sales__merchandise_sales_physical`. Add a boolean flag `is_online` to distinguish the channel.

**Required columns from staging:**
- `sale_id` (Primary key)
- `customer_id`, `product_id`, `product_name`, `category`
- `sale_date`, `sale_timestamp`, `quantity`, `unit_price`, `total_price`
- `discount_applied`, `payment_method`, `staff_member`, `haunted_house_id`
- `created_at`, `updated_at`
- `is_online` (Boolean flag: true for online sales, false for physical sales)

**Calculated columns to add:**
- `discount_category`: Categorize as 'High Discount' (≥50%), 'Medium Discount' (≥25%), 'Low Discount' (>0%), or 'No Discount' (0%) based on `discount_applied`
- `purchase_type`: Categorize as 'Bulk Purchase' (≥5 items), 'Multiple Items' (≥3 items), or 'Single Item' (<3 items) based on `quantity`
- `service_type`: Categorize as 'Staff Assisted' (when `staff_member` is not null) or 'Self Service' (when `staff_member` is null)

### 2.5 Add Documentation

Add comprehensive documentation to your dimension and fact tables including:
- Model descriptions
- Column descriptions

---

## 📤 Submission

### Before Submitting

⚠️ **IMPORTANT**: Before creating your ZIP file, delete these folders:
- `dbt_packages/`
- `dbt_internal_packages/`
- `logs/`
- `target/`
- `venv/` (if present)

These folders can become quite heavy and are not required for submission.

### Required Files/Folders

Your submission should include:
- `models/`
- `seeds/`
- `snapshots/`

### How to Submit

1. Compress the entire `horrorland` folder into a ZIP file
2. Upload the ZIP file to the assignments page

---

## 💡 Learning Objectives

By completing this homework, you'll master:
- ✅ Setting up sources in dbt
- ✅ Creating staging models for data cleaning
- ✅ Building dimension and fact tables
- ✅ Implementing snapshots for change tracking
- ✅ Adding comprehensive documentation
- ✅ Following dbt best practices and naming conventions

---

## 🛠️ Essential dbt Commands

### Install Dependencies
> **Note**: This step is only needed if using dbt Core. dbt Fusion handles dependencies automatically.
Before running any models, install the packages defined in `packages.yml`:
```bash
dbt deps
```

### Build Your Models
To create all tables and views in your Snowflake schema:
```bash
dbt build
```

### Run Specific Models
```bash
dbt build -s your_model_name
```

**Useful selectors:**
- `+your_model_name` → builds the model and its **parents (upstream models)**
- `your_model_name+` → builds the model and all **children (downstream models)**
- `+your_model_name+` → builds **everything related** (parents and children)

### Generate Documentation
```bash
dbt docs generate
dbt docs serve
```

### Other Useful Commands
| Command | Purpose |
|---------|---------|
| `dbt run` | Runs only models (not tests or seeds) |
| `dbt test` | Runs tests defined in `.yml` files |
| `dbt clean` | Removes `dbt_modules` and `target/` |
| `dbt compile` | Compiles your models without running them |
| `dbt ls -s tag:your_tag` | Selects models by tag |

---

## 📂 Project Structure

Understanding your dbt project structure:

- **`models/`**: Contains all your SQL models (staging, marts, etc.)
- **`macros/`**: Custom macros and reusable SQL functions
- **`seeds/`**: CSV files that get loaded into your database
- **`snapshots/`**: Tracks changes in your source data over time
- **`dbt_project.yml`**: Project configuration and settings
- **`packages.yml`**: External packages and dependencies

**Generated folders (can be deleted):**
- **`dbt_packages/`**: Installed packages
- **`logs/`**: dbt execution logs
- **`target/`**: Compiled SQL and artifacts

---

## 📚 Helpful Resources

### dbt Documentation
- [dbt best practices for enterprises](https://www.phdata.io/blog/accelerating-and-scaling-dbt-for-the-enterprise/)
- [dbt cheat sheet](https://github.com/bruno-szdl/cheatsheets/blob/main/dbt_cheat_sheet.pdf)
- [Models](https://docs.getdbt.com/docs/build/sql-models)
- [Tests](https://docs.getdbt.com/docs/build/data-tests)
- [Sources](https://docs.getdbt.com/docs/build/sources)
- [Seeds](https://docs.getdbt.com/docs/build/seeds)
- [Snapshots](https://docs.getdbt.com/docs/build/snapshots)
- [dbt_project.yml](https://docs.getdbt.com/reference/dbt_project.yml)
- [profiles.yml](https://docs.getdbt.com/docs/core/connect-data-platform/profiles.yml)
- [Commands](https://docs.getdbt.com/reference/commands/build)
- [Node selection](https://docs.getdbt.com/reference/node-selection/syntax)

### Pro Tips
- Check compiled SQL in `target/compiled/` to see exactly what dbt sends to Snowflake
- Use `dbt list` to see all available models, seeds, and snapshots
- Combine selectors for powerful workflows: `dbt build -s staging+ --exclude tag:skip_ci`

---

## 💬 Support & Questions

Use the appropriate Discord channels:
- `❓-duvidas-🇧🇷` — Portuguese Q&A
- `❓-questions-🇺🇸` — English Q&A
- `support-suporte-🌎` — General help

Or visit [DataGym.io](https://www.datagym.io)

---

👻 Good luck with your data modeling adventure!