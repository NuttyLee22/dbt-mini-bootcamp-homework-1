# 🎃 Horrorland dbt Workshop

[![Powered by DataGym.io](https://img.shields.io/badge/Powered%20by-DataGym.io-%23005FFF?style=for-the-badge\&logo=data\&logoColor=white)](https://www.datagym.io)

> 🚨 **IMPORTANT NOTICE – BOOTCAMP TEMPLATE**
> This repository is used **exclusively for the DataGym.io dbt mini bootcamp**.
>
> ✅ To work on your project:
>
> 1. **Clone this repository**
>
>    ```bash
>    git clone https://github.com/datagym-io/2025-08-dbt-mini-bootcamp.git
>    ```
>    ```bash
>    cd 2025-08-dbt-mini-bootcamp
>    ```
> 2. **Create your own branch** (replace `<your_name>`):
>
>    ```bash
>    git checkout -b <your_name>
>    ```
> 3. Work only inside your branch.
> 4. **❌ Do NOT open PRs or merge anything into the `main` branch.**


---

## 📚 Table of Contents

* [👻 Context](#-context)
* [❄️ Getting Started with Snowflake](#️-getting-started-with-snowflake)
* [⚙️ Setting Up dbt Fusion](#️-setting-up-dbt-fusion)
* [🛠️ Initializing Your Project](#️initializing-your-project)
* [🧹 Clean Up Default Folders](#️clean-up-default-folders)
* [💡 What You’ll Learn](#-what-youll-learn)
* [💬 Support & Questions](#-support--questions)

---

## 👻 Context

You work at **Horrorland**, a spooky and thrilling theme park.

The Halloween season is near, but something is wrong:

* Visitors are unhappy
* VIPs may not be getting their money’s worth
* Ticket pricing feels off
* Fear levels may or may not influence ratings

You’ve been tasked with answering:

1. What are the top selling products?
2. How do daily wait times correlate with customer satisfaction scores?
3. What are our most expensive costs?
4. What are the most common types of incidents per haunted house?
5. And more


---

## ❄️ Getting Started with Snowflake

### Step 1: Create a Snowflake Trial Account

1. Go to [signup.snowflake.com](https://signup.snowflake.com/)
2. Choose:

   * **Enterprise Edition**
   * **AWS** as the cloud provider
3. Set up a **username** and **password**
4. Save your **Account Identifier**

### How to find your Account Identifier:

1. Open the **Snowflake Web UI**
2. Click your **user avatar** (bottom-left)
3. Go to **Account > View Account Details**
<img src="./images/account_id_1.png" alt="Account Identifier" width="400"/>
4. Copy the `Account Identifier`, e.g.:
   `RVDLYID-LX74876`
<img src="./images/account_id_2.png" alt="Account Identifier" width="400"/>

---

### Step 2: Ingest Raw Data

We'll simulate data ingestion using SQL scripts.

1. In the Snowflake UI, click **Projects** > **Worksheets** > **+**
<img src="./images/ingest_1.png" alt="Account Identifier" width="400"/>

2. If prompted, use the role **ACCOUNTADMIN** and the warehouse **COMPUTE_WH**
<img src="./images/ingest_2.png" alt="Account Identifier" width="400"/>

3. Copy the contents of [snowflake_insert.txt](./snowflake_insert.txt)
4. Paste into the worksheet, select everything, and **run** it
<img src="./images/ingest_3.png" alt="Account Identifier" width="400"/>
This will create your raw tables.


---

## ⚙️ Setting Up dbt Fusion

We’ll use **dbt Fusion**, the new Rust-powered dbt engine. dbt Fusion is still in beta, so sometimes we might use dbt Core. If you use Windows, read below.

### ✅ Option 1 (Recommended): Install via VS Code Extension

Search for `dbtLabsInc.dbt` in the Extensions tab or use these links:

* [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=dbtLabsInc.dbt)
* [Cursor Marketplace](https://marketplace.cursorapi.com/items?itemName=dbtLabsInc.dbt)

It installs dbt Fusion automatically.


<img src="./images/extension.png" alt="Account Identifier" width="400"/>


It will ask you to register the extension within 14 days. You can register for free.

---

### 💻 Option 2: Install via CLI

#### macOS / Linux

```bash
curl -fsSL https://public.cdn.getdbt.com/fs/install/install.sh | sh -s -- --update
```
```bash
exec $SHELL
```

#### Windows (via WSL - Recommended)
If you're using Windows, we highly recommend enabling [WSL (Windows Subsystem for Linux)](https://learn.microsoft.com/en-us/windows/wsl/install) and following the Linux instructions above.

This ensures full compatibility and avoids common issues when installing dbt and Python dependencies natively on Windows.

#### Windows (Native PowerShell - Not Fully Supported)
> [!WARNING]
> Native Windows installation is not officially supported and might not work for all users. Some workshop participants in > Brazil managed to install it this way, but YMMV.

To try installing dbt Fusion CLI natively via PowerShell:

```powershell
irm https://public.cdn.getdbt.com/fs/install/install.ps1 | iex
```
```bash
Start-Process powershell
```

You might need to **restart your computer** after installation.

#### ✅ Verify Installation

```bash
dbtf --version
```

If that doesn’t work, try:
```bash
dbt --version
```

If this command works instead, you can use `dbt` in all further commands.

#### 🐍 Windows Fallback: Use dbt Core (Legacy CLI)

If you can’t install dbt Fusion on Windows, you can fall back to the classic dbt Core CLI:

##### 1. Create a virtual environment

**On Windows CMD or PowerShell:**

```powershell
python -m venv venv
```
```powershell
.\venv\Scripts\activate
```

##### 2. Install dbt for Snowflake

```bash
pip install dbt-snowflake
```

##### 3. Verify Installation

```bash
dbt --version
```


---

## 🛠️ Initializing Your Project

Use `dbtf init` to create your dbt project from scratch.

```bash
dbtf init --project-name horrorland
```

You will be prompted to fill:

| Prompt      | Recommended Value                    |
| ----------- | ------------------------------------ |
| Adapter     | `snowflake`                          |
| Account     | Your Account Identifier (e.g., RVDLYID-LX74876)              |
| User        | Your Snowflake Username  (e.g., bruno)             |
| Auth Method | `password`                           |
| Password    | Your Snowflake Password              |
| MFA         | `N` (not required for workshop)      |
| Role        | `ACCOUNTADMIN` *(for workshop only)* |
| Database    | `DEV_DATABASE` *(created in the ingestion step)*     |
| Warehouse   | `COMPUTE_WH`                         |
| Schema      | The name you want (e.g. `BRUNO`)             |

You should see a confirmation like:

<img src="./images/connection.png" alt="Account Identifier" width="400"/>

> [!WARNING]
> If you face an error in Windows that says the `profiles.yml` was not found
> Probably it was created within a .dbt folder in your project.
> Move the profiles.yml out from this folder into the root folder of your project `horrorland/profiles.yml`.
> This should fix the issue.

---

## 🧹 Clean Up Default Folders

MacOS/Linux
```bash
cd horrorland
```
```bash
rm -rf seeds macros target
```
```bash
rm -rf models/*
```

Windows (PowerShell)
```bash
cd horrorland
```
```bash
Remove-Item -Recurse -Force .\seeds, .\macros, .\target
```
```bash
Remove-Item -Recurse -Force .\models\*
```

## 🔄 Reload window

For the extension to work properly, your VSCode/Cursor workspace must be the root folder of the dbt_project, in this case `/horrorland`.

Make sure you are within the `/horrorland` folder in your terminal, and run

```bash
code . #if VSCode
```
```bash
cursor . #if Cursor
```
> If `code .` or `cursor .` doesn't work, open VS Code or Cursor manually and choose **File > Open Folder...**, then select the `horrorland` folder.


Now you're ready to start modeling!

---

## 💡 What You’ll Learn

- ✔️ Connect dbt Fusion to Snowflake
- ✔️ Ingest and clean raw data
- ✔️ Build a star schema
- ✔️ Add freshness and data quality tests
- ✔️ Use `sources`, `staging`, `marts`
- ✔️ Apply unit tests and documentation
- ✔️ Explore dbt lineage and insights

---

## 💬 Support & Questions

Use the appropriate Discord channels:

* `❓-duvidas-🇧🇷` — Portuguese Q\&A
* `❓-questions-🇺🇸` — English Q\&A
* `support-suporte-🌎` — General help

Or visit [DataGym.io](https://www.datagym.io)

---

👻 Good luck, and may your data models never haunt you!
